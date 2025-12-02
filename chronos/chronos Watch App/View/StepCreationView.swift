//
//  StepCreationView.swift
//  chronos
//
//  Created by Pepo on 02/12/25.
//

import SwiftUI

struct StepCreationView: View {
    @ObservedObject var stepCreationViewModel: StepCreationViewModel
    
    init(stepCreationViewModel: StepCreationViewModel) {
        self.stepCreationViewModel = stepCreationViewModel
    }
    
    var body: some View {
        ScrollView {
            Picker("Select a step", selection: $stepCreationViewModel.selectedStepType) {
                ForEach(StepType.allCases) { type in
                    Text(type.rawValue.capitalized)
                }
            }
            .frame(height: 60)
            .colorMultiply(.yellow)
            
            DatePicker("Select hour, minute and second", selection: $stepCreationViewModel.selectedTime, displayedComponents: [.hourMinuteAndSecond])
                .frame(height: 80)
                .colorMultiply(.yellow)
            
            CustomButtom(action: {
                
            }, buttonImageSystemName: "checkmark")
            .padding(.top, 20)
            
        }
    }
}

#Preview {
    StepCreationView(stepCreationViewModel: StepCreationViewModel(coordinator: AppCoordinator()))
}
