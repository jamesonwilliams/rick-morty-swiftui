//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/24/23.
//

import Observation

@Observable
class CharacterListViewModel {
    internal var uiState: UiState = UiState.initial()
    
    @ObservationIgnored
    private let repository = CharacterRepository()
    
    init() {
        onEvent(event: .initialLoad)
    }
    
    func onEvent(event: UiEvent) {
        Task {
            switch event {
            case .initialLoad:
                await refreshUi()
            case .scrolledToBottom:
                await refreshUi(showLoading: false)
            }
        }
    }
    
    private func refreshUi(showLoading: Bool = true) async {
        if (showLoading) {
            uiState = UiState(
                currentPage: uiState.currentPage,
                displayState: .loading,
                characterSummaries: []
            )
        }
        let result = await repository.fetchCharacters(page: uiState.currentPage)
        switch result {
        case .success(let characters):
            uiState = UiState(
                currentPage: uiState.currentPage + 1,
                displayState: .content,
                characterSummaries: uiState.characterSummaries + characters.map {
                    CharacterSummary(id: $0.id, name: $0.name, imageUrl: $0.image)
                }
            )
        case .failure(let error):
            uiState = UiState(
                currentPage: uiState.currentPage,
                displayState: DisplayState.error(String(describing: error)),
                characterSummaries: uiState.characterSummaries
            )
        }
    }
    
    struct UiState {
        let currentPage: Int
        let displayState: DisplayState
        let characterSummaries: [CharacterSummary]
        
        static func initial() -> UiState {
            UiState(
                currentPage: 1,
                displayState: .loading,
                characterSummaries: []
            )
        }
    }

    enum DisplayState {
        case loading
        case content
        case error(String)
    }

    enum UiEvent {
        case initialLoad
        case scrolledToBottom
    }
}
