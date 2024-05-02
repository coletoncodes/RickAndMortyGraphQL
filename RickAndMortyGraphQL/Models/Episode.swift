//
//  Episode.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import Foundation

struct Episode: Identifiable, Equatable {
    let airDate: String
    let characters: [Character]
    let createdAt: String
    let episodeCode: String
    let id: String
    let name: String
}

extension Episode {
    init(fromEntity entity: EpisodeEntity) {
        self.init(
            airDate: entity.airDate,
            characters: (entity.characters as? Set<CharacterEntity>)?.compactMap { Character(fromEntity: $0) } ?? [],
            createdAt: entity.createdAt,
            episodeCode: entity.episodeCode,
            id: entity.id,
            name: entity.name
        )
    }
}
