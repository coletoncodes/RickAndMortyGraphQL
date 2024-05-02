//
//  CharactersRemoteDataSource.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/1/24.
//

import Factory
import Foundation
import RickAndMortyAPI
import ApolloAPI

/// Fetches paginated lists of characters. It is tailored to manage and cache these character lists and their pagination data.
protocol CharactersRemoteDataSource {
    func loadInitialCharacters() async throws -> Paged<Character>
}

actor CharactersRemoteRepo: CharactersRemoteDataSource {
    // MARK: - Dependencies
    @Injected(\.networkingClient) private var client
    
    // MARK: - Private Properties
    private var pagedCharactersCache: Paged<Character>?
    private var nextPage: Int = 1
    
    // MARK: - Interface
    /// Fetches the first page of characters and returns a `Paged` object containing the data and a fetcher for subsequent pages.
    func loadInitialCharacters() async throws -> Paged<Character> {
        log("Fetching initial characters", .info, .networking)
        if let cache = pagedCharactersCache {
            return cache
        } else {
            return try await fetchAndCacheCharacters(for: nextPage)
        }
    }
    
    // MARK: - Helpers
    /// Fetches characters for the specified page and returns a `Paged` object.
    private func fetchAndCacheCharacters(for page: Int) async throws -> Paged<Character> {
        log("Attempting to fetch characters at page: \(page)", .info, .networking)
        let query = try await client.fetch(query: CharactersQuery(page: .some(page)))
        guard let results = query.characters?.results, let pageInfo = query.characters?.info else {
            let logStr = "The results of characters or pageInfo was were nil"
            log(logStr, .info, .networking)
            throw CharacterRemoteRepoError.nilResults(logStr)
        }
        
        let characters: [Character] = results.compactMap { result in
            if let result = result {
                return Character(fromQueryResult: result)
            }
            return nil
        }
        
        // Determine pages
        nextPage = pageInfo.next ?? nextPage
        let totalPages = pageInfo.pages ?? 0
        let hasNextPage = nextPage < totalPages
        
        // Set next page fetcher if there are more pages to fetch
        let nextPageFetcher: (() async throws -> Paged<Character>)? = hasNextPage ? { [weak self] in
            guard let self = self else {
                throw CharacterRemoteRepoError.deallocatedSelf
            }
            return try await self.fetchAndCacheCharacters(for: self.nextPage)
        } : nil
        
        let paged = Paged(data: characters, nextPageFetcher: nextPageFetcher)
        pagedCharactersCache = paged
        return paged
    }
    
    enum CharacterRemoteRepoError: Error {
        case nilResults(String)
        case deallocatedSelf
    }
}

extension Character {
    init(fromQueryResult result: CharactersQuery.Data.Characters.Result) {
        self.init(
            characterID: result.id,
            gender: result.gender.orDefault(),
            imageURLString: result.image,
            name: result.name.orDefault(),
            origin: result.origin.map { Origin(fromQueryResult: $0) },
            species: result.species.orDefault(),
            status: result.species.orDefault(),
            type: result.type.orDefault()
        )
    }
}

extension Origin {
    init(fromQueryResult result: CharactersQuery.Data.Characters.Result.Origin) {
        self.init(
            dimension: result.dimension.orDefault(),
            name: result.name.orDefault(),
            type: result.type.orDefault()
        )
    }
}
