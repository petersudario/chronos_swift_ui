//
//  PresetCreationView.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import SwiftUI

struct PresetCreationView: View {
    
    @ObservedObject var presetCreationViewModel: PresetCreationViewModel
    
    @State private var newPresetName: String = ""
    
    var body: some View {
        VStack (spacing: 30){
            TextField("New Preset", text: $newPresetName)
            
                
            VStack (spacing: 20) {
                Text("No steps added.")
                
                HStack (alignment: .center, spacing: 15){
                    CustomButtom(action: {
                        presetCreationViewModel.navigateToStepCreation()
                    }, buttonImageSystemName: "plus", backgroundColor: .gray)
                    
                    
                    CustomButtom(action: {
                        
                    }, buttonImageSystemName: "checkmark")
                    
                }
            }


            
            
        }
    }
}

#Preview {
    PresetCreationView(presetCreationViewModel: PresetCreationViewModel(coordinator: AppCoordinator()))
}
