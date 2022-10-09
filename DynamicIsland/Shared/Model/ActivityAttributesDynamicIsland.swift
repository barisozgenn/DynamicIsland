//
//  ActivityAttributesDynamicIsland.swift
//  DynamicIsland
//
//  Created by Baris OZGEN on 8.10.2022.
//

import Foundation
import ActivityKit

struct ActivityAttributesDynamicIsland: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var imageName: String
        var title: String
        var description: String
        var percent: Double
        var value: Double
        var state: Int
    }

    // Fixed non-changing properties about your activity go here!
    var dataType : DynamicIslandViewType.DataType.RawValue
    var viewType : DynamicIslandViewType.ID
}
