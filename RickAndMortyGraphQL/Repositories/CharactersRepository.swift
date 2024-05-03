//
//  CharactersRepository.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import Factory
import Foundation

final class CharactersRepository {
    // MARK: - Dependencies
    @Injected(\.charactersLocalDataSource) private var localDataSource
    @Injected(\.charactersRemoteDataSource) private var remoteDataSource
    
    // Fetches the initial page or the next page if possible
    func fetchRemoteCharacters() async throws -> Paged<Character> {
        return try await loadInitialCharacters()
    }
    
    func loadPersistedCharacters() async throws -> [Character] {
        return try await localDataSource.fetchCharacters()
    }

    // Load initial characters from remote and save to local, then initialize Paged
    private func loadInitialCharacters() async throws -> Paged<Character> {
        var initialPage = try await remoteDataSource.loadInitialCharacters()
        try await localDataSource.saveCharacters(initialPage.data) // save initial fetch
        
        // Create the initial Paged instance with a closure to handle subsequent pages
        try await self.fetchAndSavePage(page: &initialPage)
        return initialPage
    }

    // Fetches a page by number from remote, saves it locally, and returns a new Paged instance
    private func fetchAndSavePage(page: inout Paged<Character>) async throws {
        try await page.fetchNextPage()
        try await localDataSource.saveCharacters(page.data)
    }
    
    enum CharacterRepoError: Error {
        case deallocatedSelf
    }
}
