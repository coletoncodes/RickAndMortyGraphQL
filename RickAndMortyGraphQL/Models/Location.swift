//
//  Location.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import Foundation

struct Location: Identifiable, Equatable {
    let createdAt: Date
    let dimension: String
    let id: String
    let name: String
    let type: String
    let originatedCharacters: [Character]
    let currentResidents: [Character]
}
