//
//  StepCreationView.swift
//  chronowrist
//
//  Created by Pepo on 05/12/25.
//

import SwiftUI

struct StepCreationView: View {
    @ObservedObject var stepCreationViewModel: PresetCreationViewModel
    @Environment(\.dismiss) var dismiss
    
    init(stepCreationViewModel: PresetCreationViewModel) {
        self.stepCreationViewModel = stepCreationViewModel
    }
    
    var body: some View {
        ScrollView {
            Picker("Step Type", selection: $stepCreationViewModel.selectedStepType) {
                ForEach(StepType.allCases) { type in
                    Text(type.rawValue.capitalized)
                }
            }
            .frame(height: 60)
            .colorMultiply(.yellow)
            .accessibilityLabel("Step Type")
            
            DatePicker("Step Duration", selection: $stepCreationViewModel.selectedTime, displayedComponents: [.hourMinuteAndSecond])
                .frame(height: 80)
                .colorMultiply(.yellow)
                .accessibilityLabel("Step Duration")
            
            CustomButtom(action: {
                stepCreationViewModel.addStep()
                dismiss()
                
            }, buttonImageSystemName: "checkmark")
            .padding(.top, 20)
            .accessibilityLabel("Save Step")
            .accessibilityHint("Adds this step to your preset")
        }
    }
}
