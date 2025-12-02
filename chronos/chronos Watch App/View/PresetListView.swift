//
//  PresetListView.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import SwiftUI

struct PresetListView : View {
    
    @ObservedObject var coordinator: AppCoordinator // agora que eu finalmente entendi: pelo menos uma view, a inicial nesse caso, deve ter o coordinator como parâmetro. boa pepo, descobriu, cara bom
    @ObservedObject var presetListViewModel: PresetListViewModel
    
    var body: some View {
        VStack (spacing: 25) {
            Text("No presets created yet.")
            
            CustomButtom(action: presetListViewModel.navigateToPresetCreation, width: 60, buttonImageSystemName: "plus")
            
        }
    }
}

#Preview {
    PresetListView(coordinator: AppCoordinator(), presetListViewModel:  PresetListViewModel(coordinator: AppCoordinator()))
}
