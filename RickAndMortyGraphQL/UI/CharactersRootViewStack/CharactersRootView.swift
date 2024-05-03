//
//  CharactersRootView.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import SwiftUI

typealias CharactersRootView = ViewStack<CharactersRootViewState, CharactersRootVM, CharacterRootViewContent>

struct CharacterRootViewContent: ViewContent {
    typealias State = CharactersRootViewState
    @Binding var state: State
    
    var body: some View {
        Section {
            List {
                ForEach(state.characters) { character in
                    CharacterRow(character: character)
                        .onAppear {
                            state.fetchNextPage(character)
                        }
                }
            }
            .overlay(
                Text("No characters available")
                    .isHidden(state.shouldShowEmptyState)
            )
            .overlay {
                ProgressView()
                    .isHidden(state.isPerformingInitialLoad)
            }
        } footer: {
            ProgressView("Fetching more...")
                .isHidden(state.isFetchingNextPage)
        }
    }
}

extension View {
    /// Hides the view by setting the opacity to zero if isHidden is false.
    func isHidden(_ isHidden: Bool) -> some View {
        self.opacity(isHidden ? 1 : 0)
    }
}

struct CharacterRow: View {
    let character: Character
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(character.name)")
                .font(.headline)
            
            Text("Gender: \(character.gender)")
            
            Text("Status: \(character.status)")
        }
    }
}
