//
//  ApolloNetworkClient.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/1/24.
//

import Foundation
import Apollo
import ApolloAPI

/// Protocol defining the interface of a networking client that fetches GraphQL data.
protocol ApolloNetworkingClient {
    /// Fetches GraphQL data asynchronously.
    /// - Parameters:
    ///   - query: The GraphQL query to be executed.
    /// - Throws: `ApolloNetworkClientError` describing the failure.
    /// - Returns: The requested GraphQL data.
    func fetch<Query: GraphQLQuery>(query: Query) async throws -> Query.Data
}

/// The implementation of the ``ApolloNetworkingClient``.
/// In this case, we only have one URL to fetch data from, so we do not need to abstract this further with URL injection, or generics.
///
/// In larger scale applications, injecting the URL, using generics, or building seperate client configurations based on an enum (like an environment), may be preferred.
final class ApolloNetworkClient: ApolloNetworkingClient {
    private let client: ApolloClient
    
    /// Initializes the network client.
    /// > Warning:  Throws a `fatalError` if the URL is invalid, halting the application.
    init() {
        let urlString: String = "https://rickandmortyapi.com/graphql"
        guard let validURL = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }
        self.client = ApolloClient(url: validURL)
    }
    
    // MARK: - Interface
    func fetch<Query: GraphQLQuery>(query: Query) async throws -> Query.Data {
        try await withCheckedThrowingContinuation { continuation in
            self.client.fetch(query: query) { result in
                switch result {
                case .success(let result):
                    if let data = result.data {
                        // Log success with details
                        log("Successfully fetched data of type: \(type(of: Query.Data.self))", .info, .networking)
                        continuation.resume(returning: data)
                    } else {
                        // Log and handle cases where no data was returned
                        let logStr = "The returned data for query of type: \(type(of: Query.self)) was nil"
                        log(logStr, .error, .networking)
                        continuation.resume(throwing: ApolloNetworkClientError.nilData(logStr))
                    }
                case .failure(let error):
                    // Resume with the received error on failure
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}

/// Defines errors specific to the `ApolloNetworkClient`.
enum ApolloNetworkClientError: Error, LocalizedError {
    case invalidURL(URL?)
    case nilData(String)
    
    var errorDescription: String? {
        switch self {
        case let .invalidURL(url):
            "Failed to build url: \(String(describing: url))"
        case let .nilData(details):
            "The returned data was nil. Details: \(details)"
        }
    }
}
