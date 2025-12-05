//
//  PresetCreationViewModel.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import Combine
import SwiftUI

class PresetCreationViewModel: ObservableObject {
    private weak var coordinator: AppCoordinator?

    @Published var steps: [Step] = []
    
    @Published var selectedStepType: StepType = .work
    @Published var selectedTime: Date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())!
    
    init(coordinator: AppCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func addStep() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute, .second], from: selectedTime)
        
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        // Converte tudo para segundos totais
        let totalSeconds = TimeInterval((hours * 3600) + (minutes * 60) + seconds)
        
        // Só adiciona se tiver algum tempo
        if totalSeconds > 0 {
            let newStep = Step(type: selectedStepType, duration: totalSeconds)
            steps.append(newStep)
            
            // Opcional: Resetar o picker para 00:00:00
            // selectedTime = ...
        }
    }
}
