//
//  PresetListView.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import SwiftUI

struct PresetListView : View {
    
    @ObservedObject var coordinator: AppCoordinator
    @ObservedObject var presetListViewModel: PresetListViewModel

    var body: some View {
        VStack (spacing: 25) {
            Text("No presets created yet.")
            
            
            Button(action: {
                print("oiioioioio")
                presetListViewModel.navigateToPresetCreation()
            }, label: {
                Image(systemName: "plus")
            })
            .tint(.yellow)
            .background(.yellow)
            .foregroundColor(.black)
            .cornerRadius(30)
            .frame(width: 60)
            

        }
    }
}

#Preview {
    PresetListView(coordinator: AppCoordinator(), presetListViewModel:  PresetListViewModel(coordinator: AppCoordinator()))
}
