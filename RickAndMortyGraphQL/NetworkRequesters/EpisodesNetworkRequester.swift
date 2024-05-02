//
//  EpisodesNetworkRequester.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/1/24.
//

import Factory
import Foundation
import RickAndMortyAPI

protocol EpisodesNetworkRequesting {
    func getAllEpisodes() async throws -> GetAllEpisodesQuery.Data
}

final class EpisodesNetworkRequester: EpisodesNetworkRequesting {
    // MARK: - Dependencies
    @Injected(\.networkingClient) private var client
    
    // MARK: - Interface
    func getAllEpisodes() async throws -> GetAllEpisodesQuery.Data {
        return try await client.fetch(query: GetAllEpisodesQuery())
    }
}
