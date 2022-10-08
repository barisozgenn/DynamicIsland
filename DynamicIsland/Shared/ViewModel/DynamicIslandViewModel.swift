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
    
    func setActiviy() {
        
        let dynamicIslandType =  DynamicIslandViewType.deliveryExpanded
        
        startActivity(dynamicIslandType: dynamicIslandType)
        
        Task{
            try await Task.sleep(nanoseconds: UInt64(60 * Double(NSEC_PER_SEC)))
            stopActivity(dynamicIslandType: dynamicIslandType, percent: 100)
        }
        
        
    }
    
    private func startActivity(dynamicIslandType : DynamicIslandViewType) {
        
        let attributes = ActivityAttributesDynamicIsland(dataType: dynamicIslandType.dataType, viewType: dynamicIslandType.id)
        
        var contentState : ActivityAttributesDynamicIsland.ContentState
        
        switch dynamicIslandType.dataType {
            
        case DynamicIslandViewType.DataType.taxi.rawValue:
            
            let taxi: Taxi = Taxi.hailing
            
            contentState = ActivityAttributesDynamicIsland.ContentState(imageName: taxi.imageName, title: taxi.title, description: "Pickup by BO Tower on JBR St", percent: 0, value: 29.77)
            
            
            activity = try? Activity<ActivityAttributesDynamicIsland>.request(attributes: attributes, contentState: contentState, pushType: nil)
            
        case DynamicIslandViewType.DataType.delivery.rawValue:
            
            let delivery: Delivery = Delivery.preparing
            
            contentState = ActivityAttributesDynamicIsland.ContentState(imageName: delivery.imageName, title: delivery.title, description: "Preparing your food", percent: 0, value: 14.99)
           
            
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
            
            let contentState = ActivityAttributesDynamicIsland.ContentState(imageName: taxi.imageName, title: taxi.title, description: description, percent: percent, value: 29.77)
            
            Task{
                await activity?.end(using: contentState, dismissalPolicy: .immediate)
            }
            
        case DynamicIslandViewType.DataType.delivery.rawValue:
            
            let delivery: Delivery = Delivery.delivered
            let description = "Bon Appetit!"

            let contentState = ActivityAttributesDynamicIsland.ContentState(imageName: delivery.imageName, title: delivery.title, description: description, percent: percent, value: 14.99)
           
            Task{
                await activity?.end(using: contentState, dismissalPolicy: .immediate)
            }
            
        default:
            break
        }
        
        
    }
    
    private func updateActivity(dynamicIslandType : DynamicIslandViewType, percent: Double) {
        
        switch dynamicIslandType.dataType {
            
        case DynamicIslandViewType.DataType.taxi.rawValue:
            
            let taxi: Taxi = percent < 80 ? Taxi.onTheWay : Taxi.arrivingSoon
            let description = percent < 80 ? "Pickup by BO Tower on JBR St": "Meet by BO Tower on JBR St"
            
            let contentState = ActivityAttributesDynamicIsland.ContentState(imageName: taxi.imageName, title: taxi.title, description: description, percent: percent, value: 29.77)
            
            Task{
                await activity?.update(using: contentState)
            }
            
        case DynamicIslandViewType.DataType.delivery.rawValue:
            
            let delivery: Delivery = percent < 80 ? Delivery.onTheWay : Delivery.arrivingSoon
            let description = percent < 80 ? "Your food is on the way": "Your food is arriving soon"

            let contentState = ActivityAttributesDynamicIsland.ContentState(imageName: delivery.imageName, title: delivery.title, description: description, percent: percent, value: 14.99)
           
            Task{
                await activity?.update(using: contentState)
            }
            
        default:
            break
        }
        
        
    }
}
