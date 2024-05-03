// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import RickAndMortyAPI

public class Location: MockObject {
  public static let objectType: ApolloAPI.Object = RickAndMortyAPI.Objects.Location
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Location>>

  public struct MockFields {
    @Field<String>("dimension") public var dimension
    @Field<RickAndMortyAPI.ID>("id") public var id
    @Field<String>("name") public var name
    @Field<String>("type") public var type
  }
}

public extension Mock where O == Location {
  convenience init(
    dimension: String? = nil,
    id: RickAndMortyAPI.ID? = nil,
    name: String? = nil,
    type: String? = nil
  ) {
    self.init()
    _setScalar(dimension, for: \.dimension)
    _setScalar(id, for: \.id)
    _setScalar(name, for: \.name)
    _setScalar(type, for: \.type)
  }
}
