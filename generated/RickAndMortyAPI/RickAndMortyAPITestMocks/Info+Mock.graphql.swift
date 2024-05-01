// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import RickAndMortyAPI

public class Info: MockObject {
  public static let objectType: ApolloAPI.Object = RickAndMortyAPI.Objects.Info
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Info>>

  public struct MockFields {
    @Field<Int>("count") public var count
    @Field<Int>("next") public var next
    @Field<Int>("pages") public var pages
    @Field<Int>("prev") public var prev
  }
}

public extension Mock where O == Info {
  convenience init(
    count: Int? = nil,
    next: Int? = nil,
    pages: Int? = nil,
    prev: Int? = nil
  ) {
    self.init()
    _setScalar(count, for: \.count)
    _setScalar(next, for: \.next)
    _setScalar(pages, for: \.pages)
    _setScalar(prev, for: \.prev)
  }
}
