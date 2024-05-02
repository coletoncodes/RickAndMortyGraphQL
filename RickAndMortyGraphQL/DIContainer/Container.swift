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
}
