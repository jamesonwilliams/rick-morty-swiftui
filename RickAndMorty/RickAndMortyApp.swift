//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/24/23.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    let router = Router()
    
    var body: some Scene {
        WindowGroup {
            @Bindable var routerBinding = router
            NavigationStack(path: $routerBinding.navPath) {
                CharacterListScreen()
                .navigationDestination(for: Router.Destination.self) { destination in
                    switch destination {
                    case .characterListing:
                        CharacterListScreen()
                    case .characterDetails(let characterId):
                        CharacterDetailScreen(characterId: characterId)
                    }
                }
            }
            .environment(router)
        }
    }
}
