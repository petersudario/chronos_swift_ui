//
//  PresetCreationViewModel.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import Foundation
import Combine

final class PresetCreationViewModel: ObservableObject {
    
    private weak var coordinator: AppCoordinator?
    
    init(coordinator: AppCoordinator?) {
        self.coordinator = coordinator
    }
    
}
