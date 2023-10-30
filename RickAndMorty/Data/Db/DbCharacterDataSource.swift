//
//  DbCharacterDataSource.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/30/23.
//

import Foundation
import SwiftData

@MainActor
final class DbCharacterDataSource {
    private let modelContainer = try! ModelContainer(for: DbCharacter.self)
    private var modelContext: ModelContext {
        return modelContainer.mainContext
    }
    
    func saveDbCharacters(dbCharacters: [DbCharacter]) -> Result<[DbCharacter], Error> {
        dbCharacters.forEach {
            modelContext.insert($0)
        }
        do {
            try modelContext.save()
            return Result.success(dbCharacters)
        } catch {
            return Result.failure(error)
        }
    }
    
    func fetchDbCharacters(page: Int) -> Result<[DbCharacter], Error> {
        let fetchDescriptor = FetchDescriptor(
            predicate: #Predicate<DbCharacter> { $0.page == page },
            sortBy: [
                SortDescriptor<DbCharacter>(\.page),
                SortDescriptor<DbCharacter>(\.id)
            ]
        )
        do {
            return try Result.success(modelContext.fetch(fetchDescriptor))
        } catch {
            return Result.failure(error)
        }
    }
    
    func getDbCharacter(characterId: Int) -> Result<DbCharacter, Error> {
        let fetchDescriptor = FetchDescriptor(
            predicate: #Predicate<DbCharacter> { dbCharacter in
                dbCharacter.id == characterId
            }
        )
        do {
            return try Result.success(modelContext.fetch(fetchDescriptor).first!)
        } catch {
            return Result.failure(error)
        }
    }
}
