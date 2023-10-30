//
//  Router.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/30/23.
//

import Observation
import SwiftUI

@Observable
final class Router {
    var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
    public enum Destination: Codable, Hashable {
        case characterListing
        case characterDetails(characterId: Int)
    }
}
