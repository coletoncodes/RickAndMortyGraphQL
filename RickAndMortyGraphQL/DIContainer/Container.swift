//
//  Container.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/1/24.
//

import Factory
import Foundation

extension Container {
    var networkingClient: Factory<ApolloNetworkingClient> {
        self { ApolloNetworkClient() as ApolloNetworkingClient }
            .shared
    }
    
    var charactersRemoteDataSource: Factory<CharactersRemoteDataSource> {
        self { CharactersRemoteRepo() as CharactersRemoteDataSource }
            .cached
    }
    
    var charactersLocalDataSource: Factory<CharactersLocalDataSource> {
        self { CharactersLocalRepo() as CharactersLocalDataSource }
            .cached
    }
    
    var coreDataStack: Factory<CoreDataStack> {
        self { CoreDataStack.shared }
            .singleton
            .context(.test, .preview) {
                CoreDataStack.inMemoryStore
            }
    }
}
