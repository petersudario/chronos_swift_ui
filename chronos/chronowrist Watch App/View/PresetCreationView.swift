//
//  PresetCreationView.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import SwiftUI
import SwiftData

struct PresetCreationView: View {
    
    @ObservedObject var presetCreationViewModel: PresetCreationViewModel
    @State private var showingSheet = false
    @State private var newPresetName: String = ""
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack (spacing: 10){
            TextField("New Preset", text: $newPresetName)
                .accessibilityLabel("New preset")
                .accessibilityHint("Type the name of the new preset here.")
            
            
            VStack (spacing: 5) {
                if presetCreationViewModel.steps.isEmpty {
                    Spacer()
                    Text("No steps added.")
                        .accessibilityLabel("New preset")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    ForEach(presetCreationViewModel.steps) { step in
                        HStack {
                            Text(step.type.rawValue.capitalized)
                                .fontWeight(.bold)
                                .accessibilityLabel("\(step.type.rawValue)")
                            
                            
                            Spacer()
                            
                            Text(step.duration.asString())
                                .font(.system(.body, design: .monospaced))
                                .foregroundColor(.yellow)
                                .accessibilityLabel("Duration of this step: \(step.duration.asString())")
                        }
                        
                    }
                    .onDelete { indexSet in
                        presetCreationViewModel.steps.remove(atOffsets: indexSet)
                    }
                    
                }
                
                HStack (alignment: .center, spacing: 15){
                    CustomButtom(action: {
                        showingSheet = true
                    }, buttonImageSystemName: "plus", backgroundColor: .gray)
                    .accessibilityLabel("Plus icon")
                    .accessibilityHint("Add a new step to the timer set you are currently creating")
                    
                    
                    CustomButtom(action: {
                        savePreset()
                    }, buttonImageSystemName: "checkmark")
                    .disabled(newPresetName.isEmpty || presetCreationViewModel.steps.isEmpty)
                    .opacity(newPresetName.isEmpty || presetCreationViewModel.steps.isEmpty ? 0.5 : 1.0)
                    .accessibilityLabel("Checkmark icon")
                    .accessibilityHint("Save the timer set you are currently creating")
                }
            }
        }
        .sheet(isPresented: $showingSheet) {
            StepCreationView(stepCreationViewModel: presetCreationViewModel)
        }
    }
    
    private func savePreset() {
        let newPreset = Preset(
            name: newPresetName,
            steps: presetCreationViewModel.steps
        )
        
        context.insert(newPreset)
        
        dismiss()
    }
}

