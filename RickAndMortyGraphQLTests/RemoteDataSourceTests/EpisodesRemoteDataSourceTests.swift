//
//  EpisodesRemoteDataSourceTests.swift
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

final class EpisodesRemoteDataSourceTests: MockInjectingTestCase {
    private var sut: EpisodesRemoteRepo!
    private var mockClient: MockApolloNetworkingClient!
    
    override func setUp() {
        super.setUp()
        
        mockClient = Container.shared.networkingClient() as? MockApolloNetworkingClient
        sut = EpisodesRemoteRepo()
    }

    // MARK: - Tests
//    func testGetAllEpisodes_Success() async throws {
//        /** Given */
//        let mockEpisodes = Mock<Episodes>(
//            info: .init(count: 2, next: nil, pages: 1, prev: nil),
//            results: [
//                .init(name: "Episode One"),
//                .init(name: "Episode Two"),
//            ]
//        )
//        
//        let queryModel = GetAllEpisodesQuery.Data.from(mockEpisodes)
//       
//        mockClient.fetchStub = { _ in
//            return queryModel
//        }
//        
//        /** When */
//        let result = try await sut.getAllEpisodes()
//        
//        /** Then */
//        XCTAssertEqual(result.episodes, queryModel.episodes)
//    }
//    
//    func testGetAllEpisodes_Throws() async throws {
//        /** Given */
//        mockClient.fetchStub = { _ in
//            throw MockError.expected
//        }
//        
//        /** When/Then */
//        await assertThrowsAsyncError(try await sut.getAllEpisodes())
//    }
}
