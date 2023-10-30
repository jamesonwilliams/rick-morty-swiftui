//
//  CharacterDetailUi.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/30/23.
//

import SwiftUI
import CachedAsyncImage

struct CharacterDetailUI: View {
    let characterDetails: CharacterDetails
    
    var body: some View {
        VStack(alignment: .leading) {
            CachedAsyncImage(url: URL(string: characterDetails.imageUrl)) {
                if let image = $0.image {
                    image
                        .resizable()
                        .scaledToFit()
                }
            }
            VStack(alignment: .leading) {
                Text(characterDetails.name)
                    .font(.largeTitle)
                    .padding(.bottom)
                Text(characterDetails.gender)
                    .font(.headline)
                Text(characterDetails.species)
                    .font(.headline)
                Text(characterDetails.status)
                    .font(.headline)
            }.scaledToFill()
                .padding(20)
                
            Spacer()
        }
    }
}

#Preview {
    CharacterDetailUI(
        characterDetails: CharacterDetails(
            id: 20,
            name: "Ants in my Eyes Johnson",
            imageUrl: "https://rickandmortyapi.com/api/character/avatar/20.jpeg",
            gender: "Male",
            species: "Human",
            status: "unknown"
        )
    )
}
