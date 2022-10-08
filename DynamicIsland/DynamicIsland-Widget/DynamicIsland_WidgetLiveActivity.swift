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
    
    @State private var selectedDataType : DynamicIslandViewType.DataType = .taxi
    
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
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    switch selectedDataType {
                    case .taxi:
                        // ActivityAttributesDynamicIsland verilerini düzgün yap aşağıdakine göre
                        TaxiExpandedView(
                            taxi: Taxi,
                            percent: context.state.percent,
                            minute: context.state.,
                            subTitle: String)
                    }
                    // more content
                }
                
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T")
            } minimal: {
                Text("Min")
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
