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
        List {
            ForEach(state.characters) { character in
                CharacterRow(character: character)
                    .onAppear {
                        if character == state.characters.last {
                            state.fetchNextPage()
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
