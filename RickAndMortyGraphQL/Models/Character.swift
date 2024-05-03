//
//  Character.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import Foundation

struct Character: Identifiable, Equatable {
    var id: String {
        characterID.orDefault() + name
    }
    let characterID: String?
    let gender: String
    let imageURLString: String?
    let name: String
    let origin: Origin?
    let species: String
    let status: String
    let type: String
}
