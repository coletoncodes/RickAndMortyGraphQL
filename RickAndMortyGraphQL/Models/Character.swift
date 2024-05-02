//
//  Character.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import Foundation

struct Character: Identifiable, Equatable {
    let created: String
    let episodes: [Episode]
    let gender: String
    let id: String
    let image: String
    let location: Location?
    let name: String
    let origin: Location?
    let species: String
    let status: String
    let type: String
}

//extension Character {
//    init(fromEntity entity: CharacterEntity) {
//        self.init(
//            id: entity.id,
//            name: entity.name,
//            status: entity.status,
//            species: entity.species,
//            type: entity.type,
//            gender: entity.gender,
//            imageURLString: entity.imageURLString,
//            createdAt: entity.created
//        )
//    }
//}
