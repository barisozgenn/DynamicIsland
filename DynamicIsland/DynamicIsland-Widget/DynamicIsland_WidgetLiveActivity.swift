//
//  DynamicIsland_WidgetLiveActivity.swift
//  DynamicIsland-Widget
//
//  Created by Baris OZGEN on 8.10.2022.
//

import ActivityKit
import WidgetKit
import SwiftUI


struct DynamicIsland_WidgetLiveActivity: Widget {
    
    @State private var selectedDataType : DynamicIslandViewType.DataType = .delivery
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ActivityAttributesDynamicIsland.self) { context in
          
            
            // Lock screen/banner UI goes here
          
            // for activity area
            VStack {
               
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)
            .onAppear{
                setViewType(rawValue: context.attributes.dataType)
            }
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("leading").opacity(0)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("trailing").opacity(0)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    switch selectedDataType {
                    case .taxi:
                        TaxiExpandedView(
                            taxi: Taxi(rawValue: context.state.state)!,
                            percent: context.state.percent,
                            minute: Int(context.state.value),
                            subTitle: context.state.description)
                    case .delivery:
                        DeliveryExpandedView(
                            delivery: Delivery(rawValue: context.state.state)!,
                            percent: context.state.percent,
                            minute: Int(context.state.value),
                            subTitle: context.state.description)
                    }
                    // more content
                }
                
            } compactLeading: {
                HStack{
                    Image(systemName: selectedDataType == .delivery ? "bag.fill" : "car.fill")
                        .foregroundColor(selectedDataType == .delivery ? .orange : .purple)
                    Text(selectedDataType == .delivery ? "Order" : "Taxi")
                }
            } compactTrailing: {
                HStack(spacing: 3){
                    Image(systemName: "clock")
                    
                    Text("\(Int(context.state.value))m")
                }
                .font(.subheadline)
                .padding(.horizontal, 4)
                .padding(.vertical,3)
                .background(selectedDataType == .delivery ? .orange : .purple)
                .cornerRadius(4)
            } minimal: {
                
            }
            .widgetURL(URL(string: "https://www.github.com/barisozgenn"))
            .keylineTint(Color.red)
            
        }
        
    }
    
    func setViewType(rawValue: Int){
        switch rawValue {
        case DynamicIslandViewType.DataType.taxi.rawValue: selectedDataType = .taxi
            case DynamicIslandViewType.DataType.delivery.rawValue: selectedDataType = .delivery
        default:
            break
        }
    }
    
}
