//
//  MockInjectingTestCase.swift
//  RickAndMortyGraphQLTests
//
//  Created by Coleton Gorecke on 5/1/24.
//

import Factory
@testable import RickAndMortyGraphQL
import ApolloAPI
import ApolloTestSupport
import XCTest

class MockInjectingTestCase: XCTestCase {
    
    override func setUp() {
        Container.shared.manager.push()
        Container.shared.registerMocks()
    }
    
    override func tearDown() {
        Container.shared.manager.pop()
    }
    
}

extension Container {
    func registerMocks() {
        self.networkingClient.register {
            MockApolloNetworkingClient() as ApolloNetworkingClient
        }
    }
}
