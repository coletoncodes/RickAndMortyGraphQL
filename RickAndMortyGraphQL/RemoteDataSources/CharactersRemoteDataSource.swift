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

/// A generic class that encapsulates a paginated data model
/// and the mechanism to fetch subsequent pages.
/// It holds an array of data items of type `DataModel`
/// and a closure that can asynchronously fetch the next page.
class Paged<DataModel> {
    /// The current page's data
    private(set) var data: [DataModel]
    
    /// A closure that, when executed, will asynchronously fetch the next page of data.
    /// This closure is `nil` if there are no more pages to fetch.
    private var nextPageFetcher: (() async throws -> Paged<DataModel>)?
    
    /// Initializes a new instance of the `Paged` class with the given data
    /// and an optional closure to fetch the next page.
    /// - Parameters:
    ///   - data: The current page of data as an array of `DataModel`.
    ///   - nextPageFetcher: An optional closure that fetches the next page of data.
    ///     It returns an instance of `Paged<DataModel>`
    ///     or throws an error if unable to fetch the next page. Defaults to `nil`.
    init(
        data: [DataModel],
        nextPageFetcher: (() async throws -> Paged<DataModel>)? = nil
    ) {
        self.data = data
        self.nextPageFetcher = nextPageFetcher
    }
    
    /// Updates the objects data with the results of the nextPageFetcher, if it exists.
    /// Otherwise an error is thrown.
    /// - Throws: An error if there is an issue fetching the next page of data,
    ///     or no new data exists.
    func fetchNextPage() async throws {
        guard let nextPageFetcher = nextPageFetcher else {
            log("No next page to fetch", .error, .persistence)
            throw PagedError.noNextPage
        }
        
        do {
            let newPageData = try await nextPageFetcher()
            data += newPageData.data
            self.nextPageFetcher = newPageData.nextPageFetcher
        } catch {
            let errorStr = "Failed to fetch next page with error: \(error)"
            log(errorStr, .error, .networking)
            throw PagedError.fetchNextPageError(errorStr)
        }
    }
    
    /// Errors thrown from a ``Paged`` object.
    enum PagedError: Error {
        /// No next page was available
        case noNextPage
        /// An error occurred when attempting to fetch the next page.
        case fetchNextPageError(String)
    }
}

/// Fetches paginated lists of characters. It is tailored to manage and cache these character lists and their pagination data.
protocol CharactersRemoteDataSource {
    
    func loadInitialCharacters() async throws -> Paged<Character>
}

final class CharactersRemoteRepo: CharactersRemoteDataSource {
    // MARK: - Dependencies
    @Injected(\.networkingClient) private var client
    
    // MARK: - Private Properties
    private let cacheQueue = DispatchQueue(label: "com.yourapp.pagedCharactersCache")
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
        
        let nextPageFetcher: (() async throws -> Paged<Character>)? = hasNextPage ? { [weak self] in
            guard let self = self else {
                throw CharacterRemoteRepoError.deallocatedSelf
            }
            return try await self.fetchAndCacheCharacters(for: self.nextPage)
        } : nil
        
        let paged = Paged(data: characters, nextPageFetcher: nextPageFetcher)
        setCache(paged: paged)
        return paged
    }
    
    private func setCache(paged: Paged<Character>) {
        cacheQueue.sync {
            pagedCharactersCache = paged
        }
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
