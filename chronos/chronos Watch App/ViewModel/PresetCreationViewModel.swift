//
//  PresetCreationViewModel.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import Combine

final class PresetCreationViewModel: ObservableObject {
    
    private weak var coordinator: AppCoordinator?
    
    init(coordinator: AppCoordinator?) {
        self.coordinator = coordinator
    }
    
    func navigateToStepCreation() {
        let stepCreationViewModel: StepCreationViewModel = StepCreationViewModel(coordinator: coordinator)
        
        self.coordinator?.push(.stepCreationView(stepCreationViewModel))
    }
    
}
