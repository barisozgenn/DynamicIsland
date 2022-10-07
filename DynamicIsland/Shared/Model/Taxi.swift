//
//  Taxi.swift
//  DynamicIsland
//
//  Created by Baris OZGEN on 8.10.2022.
//

import Foundation

enum Taxi: Int, CaseIterable, Identifiable {
    
    case hailing
    case onTheWay
    case arrivingSoon
    
    var id : Int { return rawValue}
    
    var title : String {
        switch self {
        case .hailing: return "Taxi Hailing"
        case .onTheWay: return "On The Way"
        case .arrivingSoon: return "Arriving Soon!"
        }
    }
    
    var imageName : String {
        switch self {
        case .preparing: return "figure.wave"
        case .onTheWay: return "car.fill"
        case .arrivingSoon: return "hand.wave.fill"
        }
    }
    
}
