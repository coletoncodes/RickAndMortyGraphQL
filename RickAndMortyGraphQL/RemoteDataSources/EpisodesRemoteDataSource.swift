//
//  EpisodesRemoteDataSource.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/1/24.
//

import Factory
import Foundation
import RickAndMortyAPI

protocol EpisodesRemoteDataSource {
    func getAllEpisodes() async throws //-> GetAllEpisodesQuery.Data
}

final class EpisodesRemoteRepo: EpisodesRemoteDataSource {
    // MARK: - Dependencies
    @Injected(\.networkingClient) private var client
    
    // MARK: - Interface
    func getAllEpisodes() async throws { //}-> GetAllEpisodesQuery.Data {
//        return try await client.fetch(query: GetAllEpisodesQuery())
    }
}
