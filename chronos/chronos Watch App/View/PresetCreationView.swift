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
            
            
            VStack (spacing: 5) {
                if presetCreationViewModel.steps.isEmpty {
                    Spacer()
                    Text("No steps added.")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    ForEach(presetCreationViewModel.steps) { step in
                        HStack {
                            Text(step.type.rawValue.capitalized)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Text(step.duration.asString())
                                .font(.system(.body, design: .monospaced))
                                .foregroundColor(.yellow)
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
                    
                    
                    CustomButtom(action: {
                        savePreset()
                    }, buttonImageSystemName: "checkmark")
                    .disabled(newPresetName.isEmpty || presetCreationViewModel.steps.isEmpty)
                    .opacity(newPresetName.isEmpty || presetCreationViewModel.steps.isEmpty ? 0.5 : 1.0)
                }
            }
        }
        .sheet(isPresented: $showingSheet) {
            StepCreationView(stepCreationViewModel: presetCreationViewModel)
        }
    }
    
    private func savePreset() {
            // Cria o objeto Preset com os dados atuais
            // O SwiftData vai "capturar" os Steps que estão no array e vincular a este Preset
            let newPreset = Preset(
                name: newPresetName,
                steps: presetCreationViewModel.steps
            )
            
            // Insere no "bloco de rascunho" do banco
            context.insert(newPreset)
            
            // O Autosave do SwiftData lida com a persistência no disco.
            // Fechamos a tela.
            dismiss()
        }
}

struct StepCreationView: View {
    @ObservedObject var stepCreationViewModel: PresetCreationViewModel
    @Environment(\.dismiss) var dismiss
    
    init(stepCreationViewModel: PresetCreationViewModel) {
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
                stepCreationViewModel.addStep()
                dismiss()
                
            }, buttonImageSystemName: "checkmark")
            .padding(.top, 20)
            
        }
    }
}

