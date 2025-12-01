//
//  AppCoordinator.swift
//  chronos
//
//  Created by Pepo on 01/12/25.
//

import Combine
import SwiftUI

final class AppCoordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func push(_ destinationPath: Destination) {
        path.append(destinationPath)
    }
    
    func pop(){
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    func popToRoot(){
        path = NavigationPath()
    }
}
