// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import RickAndMortyAPI

public class Query: MockObject {
  public static let objectType: ApolloAPI.Object = RickAndMortyAPI.Objects.Query
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Query>>

  public struct MockFields {
    @Field<Characters>("characters") public var characters
    @Field<Episodes>("episodes") public var episodes
    @Field<Locations>("locations") public var locations
  }
}

public extension Mock where O == Query {
  convenience init(
    characters: Mock<Characters>? = nil,
    episodes: Mock<Episodes>? = nil,
    locations: Mock<Locations>? = nil
  ) {
    self.init()
    _setEntity(characters, for: \.characters)
    _setEntity(episodes, for: \.episodes)
    _setEntity(locations, for: \.locations)
  }
}
