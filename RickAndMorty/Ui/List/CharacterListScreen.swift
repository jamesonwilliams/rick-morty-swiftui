//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/24/23.
//

import SwiftUI

struct CharacterListScreen: View {
    @Environment(Router.self) var router
    
    @State var viewModel = CharacterListViewModel()
    
    var body: some View {
        switch(viewModel.uiState.displayState) {
        case .loading:
            LoadingUI()
        case .content:
            CharacterList(
                characterSummaries: viewModel.uiState.characterSummaries,
                onBottomReached: {
                    viewModel.onEvent(event: .scrolledToBottom)
                },
                onSummaryClicked: { summary in
                    router.navigate(to: .characterDetails(characterId: summary.id))
                }
            )
        case .error(let message):
            ErrorUI(message: message)
        }
    }
}
