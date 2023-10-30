//
//  DbCharacter.swift
//  RickAndMorty
//
//  Created by Jameson Williams on 10/30/23.
//

import SwiftData

@Model
class DbCharacter: Identifiable {
    var page: Int
    @Attribute(.unique)
    var id: Int
    var name: String
    var status: String
    var species: String
    var gender: String
    var image: String
    
    init(
        page: Int,
        id: Int,
        name: String,
        status: String,
        species: String,
        gender: String,
        image: String
    ) {
        self.page = page
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.gender = gender
        self.image = image
    }
}
