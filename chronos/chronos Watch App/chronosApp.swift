//
//  chronosApp.swift
//  chronos Watch App
//
//  Created by Pepo on 01/12/25.
//

import SwiftUI

@main
struct chronos_Watch_AppApp: App {
    
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                PresetListView(coordinator: coordinator).navigationDestination(for: Destination.self) { destination in
                    
                    switch destination {
                    case .presetCreationView(let vm):
                        PresetCreationView(presetCreationViewModel: vm)
                    }
                }
            }
        }
    }
}
