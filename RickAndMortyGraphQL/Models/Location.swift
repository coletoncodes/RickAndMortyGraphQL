//
//  Location.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import Foundation

struct Location: Identifiable, Equatable {
    let createdAt: String
    let dimension: String
    let id: String
    let name: String
    let type: String
    let originatedCharacters: [Character]
    let currentResidents: [Character]
}

extension Location {
    init(fromEntity entity: LocationEntity) {
        self.init(
            createdAt: entity.createdAt,
            dimension: entity.dimension,
            id: entity.id,
            name: entity.name,
            type: entity.type,
            originatedCharacters: (entity.originatedCharacters as? Set<CharacterEntity>)?.compactMap { Character(fromEntity: $0) } ?? [],
            currentResidents: (entity.residents as? Set<CharacterEntity>)?.compactMap { Character(fromEntity: $0) } ?? []
        )
    }
}
