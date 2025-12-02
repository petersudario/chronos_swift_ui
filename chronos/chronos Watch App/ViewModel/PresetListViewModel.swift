//
//  PresetListViewModel.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import Combine

final class PresetListViewModel: ObservableObject {
    
    private weak var coordinator: AppCoordinator?
    
    init(coordinator: AppCoordinator?) {
        self.coordinator = coordinator
    }
    
    func navigateToPresetCreation() {
        let presetCreationViewModel = PresetCreationViewModel(coordinator: coordinator)
        
        self.coordinator?.push(.presetCreationView(presetCreationViewModel))
    }
}
