//
//  StepType.swift
//  chronos
//
//  Created by Pepo on 02/12/25.
//

enum StepType: String, CaseIterable, Identifiable, Codable{
    case work, pause
    
    var id: Self { self }
    
}
