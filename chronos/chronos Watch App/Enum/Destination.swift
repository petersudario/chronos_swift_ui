//
//  Destination.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import Foundation

enum Destination: Hashable {
    
    case presetCreationView(PresetCreationViewModel)
    
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        switch (lhs, rhs) {
            case (.presetCreationView(let l), .presetCreationView(let r)):
                return l === r
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .presetCreationView(let vm):
            hasher.combine("presetCreation")
            hasher.combine(ObjectIdentifier(vm))
        }
    }
}
