//
//  Destination.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import Foundation

enum Destination: Hashable {
    
    case presetCreationView(PresetCreationViewModel)
    case stepCreationView(StepCreationViewModel)
    
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        switch (lhs, rhs) {
            case (.presetCreationView(let l), .presetCreationView(let r)):
                return l === r
            case (.stepCreationView(let l), .stepCreationView(let r)):
            return l === r
            default:
                return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .presetCreationView(let vm):
            hasher.combine("presetCreation")
            hasher.combine(ObjectIdentifier(vm))
        case .stepCreationView(let vm):
            hasher.combine("stepcCreation")
            hasher.combine(ObjectIdentifier(vm))
        }
    }
}
