//
//  Character.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import Foundation

struct Character: Identifiable, Equatable {
    let createdAt: String
    let episodes: [Episode]
    let gender: String
    let id: String
    let imageURLString: String
    let lastKnownLocation: Location?
    let name: String
    let origin: Location?
    let species: String
    let status: String
    let type: String
}

extension Character {
    init(fromEntity entity: CharacterEntity) {
        self.init(
            createdAt: entity.createdAt,
            episodes: [],// entity.episodes.map { $0 },
            gender: entity.gender,
            id: entity.id,
            imageURLString: entity.imageURLString,
            lastKnownLocation: entity.lastKnownLocation.map { Location(fromEntity: $0)},
            name: entity.name,
            origin: entity.origin.map { Location(fromEntity: $0)},
            species: entity.species,
            status: entity.status,
            type: entity.type
        )
    }
}
