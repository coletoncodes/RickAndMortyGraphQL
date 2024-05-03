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
        let initialPage = try await remoteDataSource.loadInitialCharacters()
        
        // Create the initial Paged instance with a closure to handle subsequent pages
        return await Paged(
            data: initialPage.data,
            pageInfo: initialPage.pageInfo) { [weak self] pageNumber in
                guard let self else { throw CharacterRepoError.deallocatedSelf }
                log("Fetching next page at page: \(pageNumber) and saving results", .debug, .persistence)
                try await initialPage.fetchNextPage()
                try await self.localDataSource.saveCharacters(initialPage.data)
                return try await loadInitialCharacters()
        }
    }
    
    enum CharacterRepoError: Error {
        case deallocatedSelf
    }
}
