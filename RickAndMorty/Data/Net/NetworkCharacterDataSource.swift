//
//  NetworkCharacterDataSource.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/24/23.
//

import Foundation
import Alamofire

class NetworkCharacterDataSource {
    func getCharacter(characterId: Int) async -> Result<NetworkCharacter, Error> {
        let apiEndpoint = "https://rickandmortyapi.com/api/character/\(characterId)"
        let dataTask = AF.request(apiEndpoint).serializingDecodable(NetworkCharacter.self)
        switch(await dataTask.result) {
        case.success(let response):
            return Result.success(response)
        case.failure(let error):
            return Result.failure(error)
        }
    }
    
    func fetchCharacters(page: Int) async -> Result<[NetworkCharacter], Error> {
        let apiEndpoint = "https://rickandmortyapi.com/api/character/?page=\(page)"
        let dataTask = AF.request(apiEndpoint).serializingDecodable(CharacterListResponse.self)
        switch(await dataTask.result) {
        case.success(let response):
            return Result.success(response.results)
        case.failure(let error):
            return Result.failure(error)
        }
    }
}
