//
//  PresetListView.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import SwiftUI
import SwiftData

struct PresetListView: View {
    @Query(sort: \Preset.createdAt, order: .reverse) var presets: [Preset]
    @Environment(\.modelContext) var context
    @ObservedObject var coordinator: AppCoordinator
    @ObservedObject var presetListViewModel: PresetListViewModel
    
    var body: some View {
        VStack {
            if presets.isEmpty {
                Spacer()
                Text("No presets created yet.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .accessibilityLabel("No presets available")
                Spacer()
            } else {
                List {
                    ForEach(presets) { preset in
                        NavigationLink(destination: TimerRunnerView(preset: preset)) {
                            VStack(alignment: .leading) {
                                Text(preset.name)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                                
                                Text("\(preset.steps.count) steps")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .accessibilityElement(children: .combine)
                            .accessibilityHint("Double tap to start timer")
                        }
                    }
                    .onDelete(perform: deletePresets)
                }
            }
            
            CustomButtom(action: presetListViewModel.navigateToPresetCreation, width: 60, buttonImageSystemName: "plus")
                .accessibilityLabel("Create new preset")
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
