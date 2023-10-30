//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/30/23.
//

import Observation

@Observable
class CharacterDetailViewModel {
    internal var uiState: UiState = .loading
    
    @ObservationIgnored
    private let repository = CharacterRepository()
    
    let characterId: Int
    
    init(characterId: Int) {
        self.characterId = characterId
        onEvent(event: .initialLoad)
    }
    
    func onEvent(event: UiEvent) {
        Task {
            switch event {
            case .initialLoad:
                await refreshUi()
            }
        }
    }
    
    private func refreshUi(showLoading: Bool = true) async {
        if (showLoading) {
            uiState = .loading
        }
        let result = await repository.getCharacter(characterId: characterId)
        switch result {
        case .success(let character):
            uiState = .content(
                CharacterDetails(
                    id: character.id,
                    name: character.name,
                    imageUrl: character.image,
                    gender: character.gender,
                    species: character.species,
                    status: character.status
                )
            )
        case .failure(let error):
            uiState = .error(error.localizedDescription)
        }
    }

    enum UiState {
        case loading
        case content(CharacterDetails)
        case error(String)
    }

    enum UiEvent {
        case initialLoad
    }
}
