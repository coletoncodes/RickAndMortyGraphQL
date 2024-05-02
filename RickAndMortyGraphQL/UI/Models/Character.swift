//
//  Character.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import Foundation

struct Character: Identifiable, Equatable {
    let id: UUID
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let createdAt: Date
}
