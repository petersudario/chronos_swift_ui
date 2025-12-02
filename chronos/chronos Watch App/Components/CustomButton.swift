//
//  CustomButton.swift
//  chronos
//
//  Created by Pepo on 02/12/25.
//

import SwiftUI

struct CustomButtom: View {
    let action: () -> Void
    var width: CGFloat?
    var buttonImageSystemName: String?
    var backgroundColor: Color?
    
    var body: some View {
        
        Button(action: action, label: {
            Image(systemName: buttonImageSystemName ?? "plus")
        })
        .tint(backgroundColor ?? .yellow)
        .background(backgroundColor ?? .yellow)
        .foregroundColor(.black)
        .cornerRadius(30)
        .frame(width: width ?? 60)
    }
}


#Preview {
    CustomButtom(action: {}, width: nil, buttonImageSystemName: nil, backgroundColor: nil)
}
