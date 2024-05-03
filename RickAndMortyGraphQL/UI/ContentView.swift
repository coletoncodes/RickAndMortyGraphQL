//
//  ContentView.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/1/24.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        CharactersRootView(vm: CharactersRootVM())
    }
}

#Preview {
    RootView()
}
