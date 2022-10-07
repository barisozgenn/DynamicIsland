//
//  DynamicIslandType.swift
//  DynamicIsland
//
//  Created by Baris OZGEN on 8.10.2022.
//

import Foundation

enum DynamicIslandType: CaseIterable, Identifiable {
    
    case taxi(_ taxiItem: Taxi)
    case delivery(_ deliveryItem: Delivery)
    
    var id : Int { return rawValue}

}
