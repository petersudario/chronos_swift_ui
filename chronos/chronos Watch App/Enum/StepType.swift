//
//  StepType.swift
//  chronos
//
//  Created by Pepo on 02/12/25.
//

enum StepType: String, CaseIterable, Identifiable {
    case action, pause
    
    var id: Self { self }
    
}
