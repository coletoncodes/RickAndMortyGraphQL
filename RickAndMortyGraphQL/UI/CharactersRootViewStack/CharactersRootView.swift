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
                            // Check if the currently appearing character is among the last few in the array
                            if let lastFewIndex = state.characters.index(state.characters.endIndex, offsetBy: -8, limitedBy: 0) {
                                if character == state.characters[lastFewIndex] {
                                    state.fetchNextPage()
                                }
                            }
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
        } footer: {
            ProgressView("Fetching more...")
                .opacity(state.isFetchingNextPage ? 1 : 0)
        }
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
