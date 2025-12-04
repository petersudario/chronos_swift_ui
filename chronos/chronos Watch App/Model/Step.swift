//
//  Step.swift
//  chronos
//
//  Created by Pepo on 02/12/25.
//

import Foundation

struct Step: Identifiable {
    let id = UUID()
    let type: StepType
    let duration: TimeInterval
}
