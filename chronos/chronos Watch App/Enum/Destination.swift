//
//  Destination.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import Foundation

enum Destination: Hashable {
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        switch (lhs, rhs) {
            case (.presetCreationView(let lhsVM), .presetCreationView(let rhsVM)):
            return ObjectIdentifier(lhsVM) == ObjectIdentifier(rhsVM)
        default:
            return false
        }
    }
    
    case presetCreationView(PresetCreationViewModel)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .presetCreationView(let vm):
            hasher.combine("presetCreation")
            hasher.combine(ObjectIdentifier(vm))
        }
    }
}
