//
//  LocationsRemoteDataSourceTests.swift
//  RickAndMortyGraphQLTests
//
//  Created by Coleton Gorecke on 5/1/24.
//

import Factory
@testable import RickAndMortyGraphQL
import ApolloTestSupport
import RickAndMortyAPI
import RickAndMortyAPITestMocks
import XCTest

final class LocationsRemoteDataSourceTests: MockInjectingTestCase {
    private var sut: LocationsRemoteRepo!
    private var mockClient: MockApolloNetworkingClient!
    
    override func setUp() {
        super.setUp()
        
        mockClient = Container.shared.networkingClient() as? MockApolloNetworkingClient
        sut = LocationsRemoteRepo()
    }

    // MARK: - Tests
    func testGetAllLocations_Success() async throws {
        /** Given */
        let mockEpisodes = Mock<Locations>(
            info: .init(count: 2, next: nil, pages: 1, prev: nil),
            results: [
                .init(dimension: "C-137"),
                .init(dimension: "C-138")
            ]
        )
        
        let queryModel = GetAllLocationsQuery.Data.from(mockEpisodes)
       
        mockClient.fetchStub = { _ in
            return queryModel
        }
        
        /** When */
        let result = try await sut.getAllLocations()
        
        /** Then */
        XCTAssertEqual(result.locations, queryModel.locations)
    }
    
    func testGetAllLocations_Throws() async throws {
        /** Given */
        mockClient.fetchStub = { _ in
            throw MockError.expected
        }
        
        /** When/Then */
        await assertThrowsAsyncError(try await sut.getAllLocations())
    }
}

