//
//  DynamicIslandViewType.swift
//  DynamicIsland
//
//  Created by Baris OZGEN on 8.10.2022.
//

import Foundation

enum DynamicIslandViewType: Int, CaseIterable, Identifiable {
    
    case taxiWide
    case taxiExpanded
    
    case deliveryWide
    case deliveryExpanded
    
    // for view type
    var id : Int { return rawValue}
    
    var dataType : Int {
        switch self {
        case .taxiWide, .taxiExpanded: return DataType.taxi.rawValue
        case .deliveryWide, .deliveryExpanded: return DataType.delivery.rawValue
        }
    }
    
    enum DataType : Int {
        case taxi
        case delivery
    }
}
