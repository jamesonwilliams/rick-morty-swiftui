//
//  CharacterGridItem.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/25/23.
//

import SwiftUI

struct CharacterGridItem: View {
    let characterSummary: CharacterSummary
    
    var body: some View {
        ZStack(alignment:.bottom) {
            Rectangle()
                .fill(Color.white.opacity(0.66))
                .frame(height: 30)
                .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            Text(characterSummary.name)
                .zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                .frame(height: 30)
            AsyncImage(url: URL(string: characterSummary.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
                    .frame(minHeight: 200)
            }
        }
    }
}

#Preview {
    CharacterGridItem(
        characterSummary: CharacterSummary(
            id: 20,
            name: "Ants in my Eyes Johnson",
            imageUrl: "https://rickandmortyapi.com/api/character/avatar/20.jpeg"
        )
    )
}
