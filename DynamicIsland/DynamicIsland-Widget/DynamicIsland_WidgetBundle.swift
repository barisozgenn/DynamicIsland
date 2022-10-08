//
//  DynamicIsland_WidgetBundle.swift
//  DynamicIsland-Widget
//
//  Created by Baris OZGEN on 8.10.2022.
//

import WidgetKit
import SwiftUI

@main
struct DynamicIsland_WidgetBundle: WidgetBundle {
    var body: some Widget {
        DynamicIsland_Widget()
        DynamicIsland_WidgetLiveActivity()
    }
}
