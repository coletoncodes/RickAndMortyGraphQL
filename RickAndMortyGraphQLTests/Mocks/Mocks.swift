//
//  Mocks.swift
//  RickAndMortyGraphQLTests
//
//  Created by Coleton Gorecke on 5/1/24.
//

@testable import RickAndMortyGraphQL
import Foundation
import ApolloAPI

enum MockError: Error {
    case expected
    case unexpected
}

final class MockApolloNetworkingClient: ApolloNetworkingClient {
    /// Using Any objects due to generics.
    ///
    /// Expects a ``GraphQLQuery`` type as paramater and should return ``GraphQLQuery.Data`` type. If the return can't be cast as that, a fatalError will be thrown in the method.
    var fetchStub: ((Any) async throws -> Any)!
    
    func fetch<Query>(query: Query) async throws -> Query.Data where Query : GraphQLQuery {
        let result = try await fetchStub(query as Query)
        guard let data = result as? Query.Data else {
            fatalError("Fetch stub returned incorrect type. Expected \(type(of: Query.self)) but got \(type(of: result))")
        }
        return data
    }
}
