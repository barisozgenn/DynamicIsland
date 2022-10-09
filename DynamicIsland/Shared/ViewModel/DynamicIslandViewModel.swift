//
//  DynamicIslandViewModel.swift
//  DynamicIsland
//
//  Created by Baris OZGEN on 8.10.2022.
//

import Foundation
import ActivityKit

class DynamicIslandViewModel:  ObservableObject {
    
    private var activity: Activity<ActivityAttributesDynamicIsland>? = nil
    private var waitForFirstStep = 20
    private var percent = 7.0
    private var minute = 9.0
    func setActiviy() {
       
        
        let dynamicIslandType =  DynamicIslandViewType.taxiExpanded
        
        startActivity(dynamicIslandType: dynamicIslandType, minute: minute + 5)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self] time in
            
            if waitForFirstStep > 0 { waitForFirstStep -= 1 }
            
            if waitForFirstStep < 1 {
                
                if minute < 1 {
                    
                    updateActivity(dynamicIslandType: dynamicIslandType, percent: 90, minute: 0)

                    time.invalidate()
                }
                
                if minute > 0 {
                    updateActivity(dynamicIslandType: dynamicIslandType, percent: percent, minute: minute)
                    
                    minute -= 0.1
                    percent += 1
                    
                }
                
               
            }
            
            
        })
        
        Task{
            
            try await Task.sleep(nanoseconds: UInt64(114 * Double(NSEC_PER_SEC)))
            stopActivity(dynamicIslandType: dynamicIslandType, percent: 90)
        }
    }
    
    private func startActivity(dynamicIslandType : DynamicIslandViewType, minute: Double) {
        
        let attributes = ActivityAttributesDynamicIsland(dataType: dynamicIslandType.dataType, viewType: dynamicIslandType.id)
        
        var contentState : ActivityAttributesDynamicIsland.ContentState
        
        switch dynamicIslandType.dataType {
            
        case DynamicIslandViewType.DataType.taxi.rawValue:
            
            let taxi: Taxi = Taxi.hailing
            
            contentState = ActivityAttributesDynamicIsland.ContentState(imageName: taxi.imageName, title: taxi.title, description: "Pickup by BO Tower on JBR St", percent: 0, value: minute, state: taxi.rawValue)
            
            
            activity = try? Activity<ActivityAttributesDynamicIsland>.request(attributes: attributes, contentState: contentState, pushType: nil)
            
        case DynamicIslandViewType.DataType.delivery.rawValue:
            
            let delivery: Delivery = Delivery.preparing
            
            contentState = ActivityAttributesDynamicIsland.ContentState(imageName: delivery.imageName, title: delivery.title, description: "Preparing your food", percent: 0, value: minute, state: delivery.rawValue)
           
            
            activity = try? Activity<ActivityAttributesDynamicIsland>.request(attributes: attributes, contentState: contentState, pushType: nil)
            
        default:
            break
        }
        
        
    }
    
    private func stopActivity(dynamicIslandType : DynamicIslandViewType, percent: Double) {
        switch dynamicIslandType.dataType {
            
        case DynamicIslandViewType.DataType.taxi.rawValue:
            
            let taxi: Taxi = Taxi.arrived
            let description = "Your trip is about to start"
            
            let contentState = ActivityAttributesDynamicIsland.ContentState(imageName: taxi.imageName, title: taxi.title, description: description, percent: percent, value: 0, state: taxi.rawValue)
            
            Task{
                await activity?.end(using: contentState, dismissalPolicy: .immediate)
            }
            
        case DynamicIslandViewType.DataType.delivery.rawValue:
            
            let delivery: Delivery = Delivery.delivered
            let description = "Bon Appetit!"

            let contentState = ActivityAttributesDynamicIsland.ContentState(imageName: delivery.imageName, title: delivery.title, description: description, percent: percent, value: 0, state: delivery.rawValue)
           
            Task{
                await activity?.end(using: contentState, dismissalPolicy: .immediate)
            }
            
        default:
            break
        }
        
        
    }
    
    private func updateActivity(dynamicIslandType : DynamicIslandViewType, percent: Double, minute: Double) {
        
        if percent <= 83 {
            switch dynamicIslandType.dataType {
                
            case DynamicIslandViewType.DataType.taxi.rawValue:
                
                var taxi: Taxi = percent < 72 ? Taxi.onTheWay : Taxi.arrivingSoon
                var description = percent < 72 ? "Pickup by BO Tower on JBR St": "Meet by BO Tower on JBR St"
                
                if percent > 82  {
                    taxi = Taxi.arrived
                     description = "Your trip is about to start"
                }
                
                let contentState = ActivityAttributesDynamicIsland.ContentState(imageName: taxi.imageName, title: taxi.title, description: description, percent: percent, value: minute, state: taxi.rawValue)
                
                Task{
                    await activity?.update(using: contentState)
                }
                
            case DynamicIslandViewType.DataType.delivery.rawValue:
                
                var delivery: Delivery = percent < 68 ? Delivery.onTheWay : Delivery.arrivingSoon
                var description = percent < 68 ? "Your food is on the way": "Your food is arriving soon"

                if percent > 82 {
                     delivery = Delivery.delivered
                     description = "Bon Appetit!"
                }
                
                let contentState = ActivityAttributesDynamicIsland.ContentState(imageName: delivery.imageName, title: delivery.title, description: description, percent: percent, value: minute, state: delivery.rawValue)
               
                Task{
                    await activity?.update(using: contentState)
                }
                
            default:
                break
            }
        }
       
        
        
    }
}
