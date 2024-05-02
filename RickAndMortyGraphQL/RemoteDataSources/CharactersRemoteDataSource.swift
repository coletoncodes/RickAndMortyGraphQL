//
//  CharactersRemoteDataSource.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/1/24.
//

import Factory
import Foundation
import RickAndMortyAPI

protocol CharactersRemoteDataSource {
    func getAllCharacters() async throws -> GetAllCharactersQuery.Data
}

final class CharactersRemoteRepo: CharactersRemoteDataSource {
    // MARK: - Dependencies
    @Injected(\.networkingClient) private var client
    
    // MARK: - Interface
    func getAllCharacters() async throws -> GetAllCharactersQuery.Data {
        return try await client.fetch(query: GetAllCharactersQuery())
    }
}
