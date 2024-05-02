//
//  CharactersRootView.swift
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
    @Injected(\.charactersRemoteDataSource) private var charactersRemoteDataSource
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
                let pagedCharacters = try await charactersRemoteDataSource.loadInitialCharacters()
                currentPage = pagedCharacters
                self.state.characters = pagedCharacters.data
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
                self.state.characters = currentPage.data
            } catch {
                log("Failed to load next page of characters: \(error)", .error, .viewModel)
            }
        }
    }
}

import SwiftUI

typealias CharactersRootView = ViewStack<CharactersRootViewState, CharactersRootVM, CharacterRootViewContent>

struct CharacterRootViewContent: ViewContent {
    typealias State = CharactersRootViewState
    @Binding var state: State
    
    var body: some View {
        List(state.characters) { character in
            CharacterRow(character: character)
                .onAppear {
                    if character == state.characters.last {
                        state.fetchNextPage()
                    }
                }
        }
        .overlay(
            Text("No characters available")
                .opacity(state.shouldShowEmptyState ? 1 : 0)
        )
        .overlay {
            ProgressView()
                .opacity(state.isPerformingInitialLoad ? 1 : 0)
        }
    }
}

struct CharacterRow: View {
    let character: Character
    
    var body: some View {
        Text(character.name)
    }
}
