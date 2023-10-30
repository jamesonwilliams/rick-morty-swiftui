//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/24/23.
//

import Foundation

class CharacterRepository {
    private let networkCharacterDataSource: NetworkCharacterDataSource
    private let dbCharacterDataSource: DbCharacterDataSource
    
    @MainActor
    private init() {
        self.networkCharacterDataSource = NetworkCharacterDataSource()
        self.dbCharacterDataSource = DbCharacterDataSource()
    }
    
    @MainActor
    static let shared = CharacterRepository()
    
    func getCharacter(characterId: Int) async -> Result<Character, Error> {
        let result = await dbCharacterDataSource.getDbCharacter(characterId: characterId)
        switch(result) {
        case .success(let dbCharacter):
            return Result.success(asCharacter(dbCharacter))
        case .failure(let error):
            return Result.failure(error)
        }
    }
    
    func fetchCharacters(page: Int) async -> Result<[Character], Error> {
        // See if we have characters saved locally
        let localResult = await dbCharacterDataSource.fetchDbCharacters(page: page)
        switch(localResult) {
        case .success(let dbCharacters):
            if (dbCharacters.isEmpty) {
                break
            }
            // If so, return them.
            let characters = dbCharacters.map { asCharacter($0) }
            return Result.success(characters)
        case .failure(_):
            // Otherwise, we'll fetch them below.
            break
        }
        
        // Fetch network characters.
        print("Falling back to network. Fetching page \(page)")
        let networkResult = await networkCharacterDataSource.fetchCharacters(page: page)
        switch(networkResult) {
        case .success(let networkCharacters):
            // If they exist, persist them and return them.
            let characters = networkCharacters.map { asCharacter($0) }
            let dbCharacters = networkCharacters.map { asDbCharacter(page, $0) }
            let saveResult = await dbCharacterDataSource.saveDbCharacters(dbCharacters: dbCharacters)
            switch(saveResult) {
            case .success(_):
                return Result.success(characters)
            case .failure(let error):
                return Result.failure(error)
            }
        case .failure(let error):
            // None saved locally, none available remotely. Fail.
            return Result.failure(error)
        }
    }
    
    private func asCharacter(_ networkCharacter: NetworkCharacter) -> Character {
        return Character(
            id: networkCharacter.id,
            name: networkCharacter.name,
            status: networkCharacter.status.rawValue,
            species: networkCharacter.species,
            gender: networkCharacter.gender.rawValue,
            image: networkCharacter.image
        )
    }
    
    private func asDbCharacter(_ page: Int, _ networkCharacter: NetworkCharacter) -> DbCharacter {
        return DbCharacter(
            page: page,
            id: networkCharacter.id,
            name: networkCharacter.name,
            status: networkCharacter.status.rawValue,
            species: networkCharacter.species,
            gender: networkCharacter.gender.rawValue,
            image: networkCharacter.image
        )
    }
    
    private func asCharacter(_ dbCharacter: DbCharacter) -> Character {
        return Character(
            id: dbCharacter.id,
            name: dbCharacter.name,
            status: dbCharacter.status,
            species: dbCharacter.species,
            gender: dbCharacter.gender,
            image: dbCharacter.image
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
