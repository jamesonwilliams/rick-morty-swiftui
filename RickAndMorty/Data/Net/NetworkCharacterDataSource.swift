//
//  NetworkCharacterDataSource.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/24/23.
//

import Foundation

class NetworkCharacterDataSource {
    func fetchCharacters(page: Int) async -> Result<[NetworkCharacter], Error> {
        do {
            let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)")!
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            let response = try JSONDecoder().decode(CharacterListResponse.self, from: data)
            return Result.success(response.results)
        } catch {
            return Result.failure(error)
        }
    }
}
