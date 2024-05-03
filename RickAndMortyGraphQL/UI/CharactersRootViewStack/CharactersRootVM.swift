//
//  CharactersRootVM.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import Factory
import Foundation

struct CharactersRootViewState: ViewState {
    var characters: [Character] = []
    var isPerformingInitialLoad: Bool = false
    var fetchNextPage: (Character) -> Void = { _ in }
    
    var shouldShowEmptyState: Bool {
        characters.isEmpty
    }
    
    var isFetchingNextPage: Bool = false
    
    var lastCharacterIndexForFetchNextPage: Int? {
        let refreshOffsetIndex = -8
        guard characters.count >= refreshOffsetIndex else { return nil }
        return self.characters.index(characters.endIndex, offsetBy: refreshOffsetIndex, limitedBy: 0)
    }
}

class CharactersRootVM: ViewModel<CharactersRootViewState> {
    // MARK: - Dependencies
    // TODO: - Replace with interactor
    //    @Injected(\.charactersRemoteDataSource) private var charactersRemoteDataSource
    private let charactersRespository = CharactersRepository()
    private var currentPage: Paged<Character>?
    
    override func configureState() {
        fetchPersistedCharacters()
        
        state.fetchNextPage = { [weak self] character in
            guard let self else { return }
            if let fetchNextPageIndex = state.lastCharacterIndexForFetchNextPage {
                if character == state.characters[fetchNextPageIndex] {
                    self.fetchNextPage()
                }
            }
        }
    }
    
    private func fetchPersistedCharacters() {
        log("Fetching persisted characters", .debug, .viewModel)
        Task {
            self.state.isPerformingInitialLoad = true
            defer { self.state.isPerformingInitialLoad = false }
            do {
                self.state.characters = try await charactersRespository.loadPersistedCharacters()
                log("Fetched \(self.state.characters.count) persisted characters", .debug, .viewModel)
                if self.state.characters.isEmpty {
                    // Fresh fetch
                    self.state.characters = try await charactersRespository.fetchRemoteCharacters().data
                }
            } catch {
                log("Failed to load initial characters: \(error)", .error, .viewModel)
            }
            await setPaged()
        }
    }
    
    private func setPaged() async {
        log("Setting up paged instance", .debug, .viewModel)
        // setup next page
        do {
            let pagedCharacters = try await charactersRespository.fetchRemoteCharacters()
            currentPage = pagedCharacters
        } catch {
            log("Failed to fetch remote characters with error: \(error)", .error, .viewModel)
        }
    }
    
    private func fetchNextPage() {
        guard !state.isFetchingNextPage, let currentPage = currentPage else { return }
        log("Fetching next page", .debug, .viewModel)
        
        Task {
            self.state.isFetchingNextPage = true
            defer { self.state.isFetchingNextPage = false }
            do {
                try await currentPage.fetchNextPage()
                self.state.characters = await currentPage.data
            } catch {
                log("Failed to load next page of characters: \(error)", .error, .viewModel)
            }
        }
    }
}
