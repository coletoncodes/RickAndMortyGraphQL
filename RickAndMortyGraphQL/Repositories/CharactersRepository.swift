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
    
    private var currentPage: Paged<Character>?
    
    private func getRemoteCharacters() async throws -> [Character] {
        if let currentPage {
            try await currentPage.fetchNextPage()
            let remoteData = await currentPage.data
            
        } else {
            currentPage = try await remoteDataSource.loadInitialCharacters()
            return try await localDataSource.fetchCharacters()
        }
    }
}
