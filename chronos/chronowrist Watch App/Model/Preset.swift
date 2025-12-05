//
//  Preset.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import Foundation
import SwiftData

@Model
class Preset {
    var id: UUID
    var name: String
    var createdAt: Date
    
    @Relationship(deleteRule: .cascade)
    var steps: [Step]
    
    init(name: String, steps: [Step]) {
        self.id = UUID()
        self.name = name
        self.createdAt = Date()
        self.steps = steps
    }
}
