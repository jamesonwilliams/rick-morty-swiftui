//
//  CharacterList.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/25/23.
//

import SwiftUI

struct CharacterList: View {
    let characterSummaries: [CharacterSummary]
    let onBottomReached: () -> Void
    let onSummaryClicked: (CharacterSummary) -> Void

    private let twoColumnGrid = [
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40), spacing: 0)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: twoColumnGrid, alignment: .leading, spacing: 0) {
                ForEach(characterSummaries, id: \.id) { summary in
                    CharacterGridItem(characterSummary: summary)
                        .onAppear {
                            if (summary == characterSummaries.last) {
                                onBottomReached()
                            }
                        }
                        .onTapGesture {
                            onSummaryClicked(summary)
                        }
                }
            }
        }
    }
}

#Preview {
    CharacterList(
        characterSummaries: [
            CharacterSummary(
                id: 20,
                name: "Ants in my Eyes Johnson",
                imageUrl: "https://rickandmortyapi.com/api/character/avatar/20.jpeg"
            )
        ],
        onBottomReached: {},
        onSummaryClicked: { character in
            print("Tap on \(character)!")
        }
    )
}
