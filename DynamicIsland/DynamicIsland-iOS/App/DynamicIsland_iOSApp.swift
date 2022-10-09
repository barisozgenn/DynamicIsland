//
//  DynamicIsland_iOSApp.swift
//  DynamicIsland-iOS
//
//  Created by Baris OZGEN on 8.10.2022.
//

import SwiftUI

@main
struct DynamicIsland_iOSApp: App {
    @StateObject private var vm = DynamicIslandViewModel()
    var body: some Scene {
        WindowGroup {
            DynamicIslandView()
                .environmentObject(vm)
        }
    }
}
