//
//  LocationsRemoteDataSource.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/1/24.
//

import Factory
import Foundation
import RickAndMortyAPI

protocol LocationsRemoteDataSource {
    func getAllLocations() async throws -> GetAllLocationsQuery.Data
}

final class LocationsRemoteRepo: LocationsRemoteDataSource {
    // MARK: - Dependencies
    @Injected(\.networkingClient) private var client
    
    // MARK: - Interface
    func getAllLocations() async throws -> GetAllLocationsQuery.Data {
        return try await client.fetch(query: GetAllLocationsQuery())
    }
}
