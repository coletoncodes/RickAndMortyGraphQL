// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import RickAndMortyAPI

public class Episode: MockObject {
  public static let objectType: ApolloAPI.Object = RickAndMortyAPI.Objects.Episode
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Episode>>

  public struct MockFields {
    @Field<String>("episode") public var episode
    @Field<RickAndMortyAPI.ID>("id") public var id
    @Field<String>("name") public var name
  }
}

public extension Mock where O == Episode {
  convenience init(
    episode: String? = nil,
    id: RickAndMortyAPI.ID? = nil,
    name: String? = nil
  ) {
    self.init()
    _setScalar(episode, for: \.episode)
    _setScalar(id, for: \.id)
    _setScalar(name, for: \.name)
  }
}
