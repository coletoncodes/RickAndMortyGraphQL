// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import RickAndMortyAPI

public class Query: MockObject {
  public static let objectType: ApolloAPI.Object = RickAndMortyAPI.Objects.Query
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Query>>

  public struct MockFields {
    @Field<Character>("character") public var character
    @Field<Characters>("characters") public var characters
    @Field<Episode>("episode") public var episode
    @Field<Episodes>("episodes") public var episodes
    @Field<Location>("location") public var location
    @Field<Locations>("locations") public var locations
  }
}

public extension Mock where O == Query {
  convenience init(
    character: Mock<Character>? = nil,
    characters: Mock<Characters>? = nil,
    episode: Mock<Episode>? = nil,
    episodes: Mock<Episodes>? = nil,
    location: Mock<Location>? = nil,
    locations: Mock<Locations>? = nil
  ) {
    self.init()
    _setEntity(character, for: \.character)
    _setEntity(characters, for: \.characters)
    _setEntity(episode, for: \.episode)
    _setEntity(episodes, for: \.episodes)
    _setEntity(location, for: \.location)
    _setEntity(locations, for: \.locations)
  }
}
