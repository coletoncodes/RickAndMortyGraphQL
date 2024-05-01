// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import RickAndMortyAPI

public class Character: MockObject {
  public static let objectType: ApolloAPI.Object = RickAndMortyAPI.Objects.Character
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Character>>

  public struct MockFields {
    @Field<String>("created") public var created
    @Field<[Episode?]>("episode") public var episode
    @Field<String>("gender") public var gender
    @Field<RickAndMortyAPI.ID>("id") public var id
    @Field<String>("image") public var image
    @Field<Location>("location") public var location
    @Field<String>("name") public var name
    @Field<Location>("origin") public var origin
    @Field<String>("species") public var species
    @Field<String>("status") public var status
    @Field<String>("type") public var type
  }
}

public extension Mock where O == Character {
  convenience init(
    created: String? = nil,
    episode: [Mock<Episode>?]? = nil,
    gender: String? = nil,
    id: RickAndMortyAPI.ID? = nil,
    image: String? = nil,
    location: Mock<Location>? = nil,
    name: String? = nil,
    origin: Mock<Location>? = nil,
    species: String? = nil,
    status: String? = nil,
    type: String? = nil
  ) {
    self.init()
    _setScalar(created, for: \.created)
    _setList(episode, for: \.episode)
    _setScalar(gender, for: \.gender)
    _setScalar(id, for: \.id)
    _setScalar(image, for: \.image)
    _setEntity(location, for: \.location)
    _setScalar(name, for: \.name)
    _setEntity(origin, for: \.origin)
    _setScalar(species, for: \.species)
    _setScalar(status, for: \.status)
    _setScalar(type, for: \.type)
  }
}
