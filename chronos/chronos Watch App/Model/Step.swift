//
//  Step.swift
//  chronos
//
//  Created by Pepo on 02/12/25.
//

import Foundation
import SwiftData

@Model
class Step {
    var id: UUID
    var type: StepType
    var createdAt: Date
    var duration: TimeInterval
    
    init(type: StepType, duration: TimeInterval) {
        self.id = UUID()
        self.type = type
        self.createdAt = Date()
        self.duration = duration
    }
}
