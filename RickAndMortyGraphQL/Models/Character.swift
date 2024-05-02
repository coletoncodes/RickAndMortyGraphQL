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
//            created: entity.createdAt,
//            episodes: <#T##[Episode]#>,
//            gender: <#T##String#>,
//            id: <#T##String#>,
//            image: <#T##String#>,
//            location: <#T##Location?#>,
//            name: <#T##String#>,
//            origin: <#T##Location?#>,
//            species: <#T##String#>,
//            status: <#T##String#>,
//            type: <#T##String#>
//        )
//    }
//}
