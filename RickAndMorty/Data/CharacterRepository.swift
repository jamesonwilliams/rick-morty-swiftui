//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/24/23.
//

import Foundation

class CharacterRepository {
    private let networkCharacterDataSource = NetworkCharacterDataSource()
    
    func getCharacter(characterId: Int) async -> Result<Character, Error> {
        let result = await networkCharacterDataSource.getCharacter(characterId: characterId)
        switch(result) {
        case .success(let dbCharacter):
            return Result.success(asCharacter(dbCharacter))
        case .failure(let error):
            return Result.failure(error)
        }
    }
    
    func fetchCharacters(page: Int) async -> Result<[Character], Error> {
        let networkResult = await networkCharacterDataSource.fetchCharacters(page: page)
        switch(networkResult) {
        case .success(let networkCharacters):
            let characters = networkCharacters.map { asCharacter($0) }
            return Result.success(characters)
        case .failure(let error):
            return Result.failure(error)
        }
    }
    
    private func asCharacter(_ networkCharacter: NetworkCharacter) -> Character {
        return Character.init(
            id: networkCharacter.id,
            name: networkCharacter.name,
            status: networkCharacter.status.rawValue,
            species: networkCharacter.species,
            gender: networkCharacter.gender.rawValue,
            image: networkCharacter.image
        )
    }
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
}
