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
    func testGetAllCharacters_Success() async throws {
        /** Given */
        let mockCharacters = Mock<Characters>(
            info: .init(count: 2, next: nil, pages: 1, prev: nil),
            results: [
                .init(created: "2017-11-04T18:48:46.250Z", gender: "Male",name: "Rick", species: "Human", status: "Alive"),
                .init(created: "2017-11-04T18:48:46.250Z", gender: "Male",name: "Morty", species: "Human", status: "Alive"),
            ]
        )
        
        let queryModel = GetAllCharactersQuery.Data.from(mockCharacters)
       
        mockClient.fetchStub = { _ in
            return queryModel
        }
        
        /** When */
        let result = try await sut.getAllCharacters()
        
        /** Then */
        XCTAssertEqual(result.characters, queryModel.characters)
    }
    
    func testGetAllCharacters_Throws() async throws {
        /** Given */
        mockClient.fetchStub = { _ in
            throw MockError.expected
        }
        
        /** When/Then */
        await assertThrowsAsyncError(try await sut.getAllCharacters())
    }
}
