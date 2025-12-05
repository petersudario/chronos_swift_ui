//
//  PresetListView.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import SwiftUI
import SwiftData

struct PresetListView : View {
    @Query(sort: \Preset.createdAt, order: .reverse) var presets: [Preset]
    @Environment(\.modelContext) var context
    @ObservedObject var coordinator: AppCoordinator // agora que eu finalmente entendi: pelo menos uma view, a inicial nesse caso, deve ter o coordinator como parâmetro. boa pepo, descobriu, cara bom
    @ObservedObject var presetListViewModel: PresetListViewModel
    
    var body: some View {
        VStack  {
            VStack {
                if (presets.isEmpty){
                    Text("No presets created yet.")
                    
                }
                else {
                    List {
                        ForEach(presets) { preset in
                            NavigationLink(destination: TimerRunnerView(preset: preset)) {
                                VStack(alignment: .leading) {
                                    Text(preset.name)
                                        .font(.headline)
                                    
                                    Text("\(preset.steps.count) steps")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                    
                                }
                            }
                        }
                        .onDelete(perform: deletePresets)
                    }
                    
                    
                }
            }
            Spacer()
            CustomButtom(action: presetListViewModel.navigateToPresetCreation, width: 60, buttonImageSystemName: "plus")
        }
        
    }
    
    private func deletePresets(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(presets[index])
            }
        }
    }
}
