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
    
    var charactersNetworkRequesting: Factory<CharactersNetworkRequesting> {
        self { CharactersNetworkRequester() as CharactersNetworkRequesting }
            .cached
    }
    
    var episodesNetworkRequesting: Factory<EpisodesNetworkRequesting> {
        self { EpisodesNetworkRequester() as EpisodesNetworkRequesting }
            .cached
    }
    
    var locationsNetworkRequesting: Factory<LocationsNetworkRequesting> {
        self { LocationsNetworkRequester() as LocationsNetworkRequesting }
            .cached
    }
}
