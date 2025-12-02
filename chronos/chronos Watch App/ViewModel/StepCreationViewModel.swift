//
//  StepCreationViewModel.swift
//  chronos
//
//  Created by Pepo on 02/12/25.
//

import Combine
import SwiftUI

final class StepCreationViewModel: ObservableObject {
    
    private weak var coordinator: AppCoordinator?
    
    @State var selectedTime: Date = Date()
    @State var selectedStepType: StepType = .action

    
    init(coordinator: AppCoordinator?) {
        self.coordinator = coordinator
    }
}
