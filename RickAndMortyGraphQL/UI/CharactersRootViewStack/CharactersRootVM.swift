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
    var fetchNextPage: () -> Void = { }
    
    var shouldShowEmptyState: Bool {
        isPerformingInitialLoad
    }
    
    var isFetchingNextPage: Bool = false
}

class CharactersRootVM: ViewModel<CharactersRootViewState> {
    // MARK: - Dependencies
    // TODO: - Replace with interactor
//    @Injected(\.charactersRemoteDataSource) private var charactersRemoteDataSource
    private let charactersRespository = CharactersRepository()
    private var currentPage: Paged<Character>?
    
    override func configureState() {
        fetchInitialCharacters()
        
        state.fetchNextPage = { [weak self] in
            self?.fetchNextPage()
        }
    }
    
    private func fetchInitialCharacters() {
        Task {
            self.state.isPerformingInitialLoad = true
            defer { self.state.isPerformingInitialLoad = false }
            do {
                let pagedCharacters = try await charactersRespository.fetchCharacters()
                currentPage = pagedCharacters
                self.state.characters = await pagedCharacters.data
            } catch {
                log("Failed to load initial characters: \(error)", .error, .viewModel)
            }
        }
    }
    
    func fetchNextPage() {
        guard !state.isFetchingNextPage, let currentPage = currentPage else { return }
        
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
