//
//  Delivery.swift
//  DynamicIsland
//
//  Created by Baris OZGEN on 8.10.2022.
//

import Foundation


enum Delivery: Int, CaseIterable, Identifiable {
    
    case preparing
    case onTheWay
    case arrivingSoon
    case delivered
    
    var id : Int { return rawValue}
    
    var title : String {
        switch self {
        case .preparing: return "Preparing"
        case .onTheWay: return "On The Way"
        case .arrivingSoon: return "Arriving Soon!"
        case .delivered: return "Delivered"
        }
    }
    
    var imageName : String {
        switch self {
        case .preparing: return "flame"
        case .onTheWay: return "figure.outdoor.cycle"
        case .arrivingSoon: return "figure.walk.motion"
        case .delivered: return "bag.fill"
        }
    }
    
}
