//
//  CharactersRemoteRepoTests.swift
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

final class CharactersRemoteRepoTests: MockInjectingTestCase {
    private var sut: CharactersRemoteRepo!
    private var mockClient: MockApolloNetworkingClient!
    
    override func setUp() {
        super.setUp()
        
        mockClient = Container.shared.networkingClient() as? MockApolloNetworkingClient
        sut = CharactersRemoteRepo()
    }
    
    // MARK: - Tests
    func testGetInitialCharacters_Success() async throws {
        /** Given */
        let mockCharacters = Mock<Characters>.init(
            info: Mock<Info>.init(count: 2, next: 2, pages: 1, prev: 0),
            results: [
                .init(name: "Rick"),
                .init(name: "Morty")
            ]
        )
        
        let queryModel = CharactersQuery.Data.from(mockCharacters)
        
        mockClient.fetchStub = { queryType in
            XCTAssertTrue(queryType is CharactersQuery.Type)
            return queryModel
        }
        
        /** When */
        let result = try await sut.loadInitialCharacters()
        
        /** Then */
        //        XCTAssertEqual(result.data, queryModel.characters.)
        
    }
    
    //    func testGetAllCharacters_Throws() async throws {
    //        /** Given */
    //        mockClient.fetchStub = { _ in
    //            throw MockError.expected
    //        }
    //
    //        /** When/Then */
    //        await assertThrowsAsyncError(try await sut.getAllCharacters())
    //    }
}
