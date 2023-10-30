//
//  CharacterDetailScreen.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/30/23.
//

import SwiftUI

struct CharacterDetailScreen: View {
    @State var viewModel: CharacterDetailViewModel
    
    init(characterId: Int) {
        self.viewModel = CharacterDetailViewModel(characterId: characterId)
    }
    
    var body: some View {
        switch(viewModel.uiState) {
        case .loading:
            LoadingUI()
        case .content(let characterDetails):
            CharacterDetailUI(characterDetails: characterDetails)
        case .error(let message):
            ErrorUI(message: message)
        }
    }
}
