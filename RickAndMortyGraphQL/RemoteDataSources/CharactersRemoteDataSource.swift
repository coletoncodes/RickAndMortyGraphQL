//
//  CharactersRemoteDataSource.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/1/24.
//

import Factory
import Foundation
import RickAndMortyAPI

/// Fetches paginated lists of characters. It is tailored to manage and cache these character lists and their pagination data.
/// Callers should own the count of the page to fetch.
protocol CharactersRemoteDataSource {
    func getCharactersByPage(page: Int) async throws -> [Character]
}

final class CharactersRemoteRepo: CharactersRemoteDataSource {
    @Injected(\.networkingClient) private var client
    private var charactersByPageCache: [Int: [Character]] = [:]
    private let cacheQueue = DispatchQueue(label: "com.yourapp.charactersByPageCacheQueue")

    func getCharactersByPage(page: Int) async throws -> [Character] {
        if let cachedCharacters = getCharactersFromCache(for: page) {
            return cachedCharacters
        } else {
            let characters = try await fetchAndCacheCharacters(for: page)
            return characters
        }
    }

    private func getCharactersFromCache(for page: Int) -> [Character]? {
        return cacheQueue.sync {
            charactersByPageCache[page]
        }
    }

    private func fetchAndCacheCharacters(for page: Int) async throws -> [Character] {
        let query = try await client.fetch(query: CharactersQuery(page: .some(page)))
        guard let results = query.characters?.results else {
            log("The results of characters were nil", .info, .networking)
            return []
        }
        
        let characters: [Character] = results.compactMap { result in
            guard let result = result else { return nil }
            return Character(fromQueryResult: result)
        }
        
        cacheQueue.sync {
            charactersByPageCache[page] = characters
        }
        
        return characters
    }
}

extension Character {
    init(fromQueryResult result: CharactersQuery.Data.Characters.Result) {
        self.init(
            id: result.id,
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
