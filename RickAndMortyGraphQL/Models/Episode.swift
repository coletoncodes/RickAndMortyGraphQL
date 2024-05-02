//
//  Episode.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import Foundation

struct Episode: Identifiable, Equatable {
    let airDate: Date
    let characters: [Character]
    let created: String
    let episodeCode: String
    let id: String
    let name: String
}
