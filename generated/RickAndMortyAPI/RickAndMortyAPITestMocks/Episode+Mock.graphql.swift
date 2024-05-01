// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import RickAndMortyAPI

public class Episode: MockObject {
  public static let objectType: ApolloAPI.Object = RickAndMortyAPI.Objects.Episode
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Episode>>

  public struct MockFields {
    @Field<String>("air_date") public var air_date
    @Field<[Character?]>("characters") public var characters
    @Field<String>("created") public var created
    @Field<String>("episode") public var episode
    @Field<RickAndMortyAPI.ID>("id") public var id
    @Field<String>("name") public var name
  }
}

public extension Mock where O == Episode {
  convenience init(
    air_date: String? = nil,
    characters: [Mock<Character>?]? = nil,
    created: String? = nil,
    episode: String? = nil,
    id: RickAndMortyAPI.ID? = nil,
    name: String? = nil
  ) {
    self.init()
    _setScalar(air_date, for: \.air_date)
    _setList(characters, for: \.characters)
    _setScalar(created, for: \.created)
    _setScalar(episode, for: \.episode)
    _setScalar(id, for: \.id)
    _setScalar(name, for: \.name)
  }
}
