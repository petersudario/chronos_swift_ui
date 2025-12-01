//
//  PresetListViewModel.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import Combine

class PresetListViewModel: ObservableObject {
    @Published var presets: [Preset] = []
}
