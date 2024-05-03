// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class LocationsQuery: GraphQLQuery {
  public static let operationName: String = "Locations"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Locations($page: Int) { locations(page: $page) { __typename info { __typename count next pages prev } results { __typename dimension id name type } } }"#
    ))

  public var page: GraphQLNullable<Int>

  public init(page: GraphQLNullable<Int>) {
    self.page = page
  }

  public var __variables: Variables? { ["page": page] }

  public struct Data: RickAndMortyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("locations", Locations?.self, arguments: ["page": .variable("page")]),
    ] }

    /// Get the list of all locations
    public var locations: Locations? { __data["locations"] }

    public init(
      locations: Locations? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": RickAndMortyAPI.Objects.Query.typename,
          "locations": locations._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(LocationsQuery.Data.self)
        ]
      ))
    }

    /// Locations
    ///
    /// Parent Type: `Locations`
    public struct Locations: RickAndMortyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Locations }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("info", Info?.self),
        .field("results", [Result?]?.self),
      ] }

      public var info: Info? { __data["info"] }
      public var results: [Result?]? { __data["results"] }

      public init(
        info: Info? = nil,
        results: [Result?]? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": RickAndMortyAPI.Objects.Locations.typename,
            "info": info._fieldData,
            "results": results._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(LocationsQuery.Data.Locations.self)
          ]
        ))
      }

      /// Locations.Info
      ///
      /// Parent Type: `Info`
      public struct Info: RickAndMortyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Info }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("count", Int?.self),
          .field("next", Int?.self),
          .field("pages", Int?.self),
          .field("prev", Int?.self),
        ] }

        /// The length of the response.
        public var count: Int? { __data["count"] }
        /// Number of the next page (if it exists)
        public var next: Int? { __data["next"] }
        /// The amount of pages.
        public var pages: Int? { __data["pages"] }
        /// Number of the previous page (if it exists)
        public var prev: Int? { __data["prev"] }

        public init(
          count: Int? = nil,
          next: Int? = nil,
          pages: Int? = nil,
          prev: Int? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": RickAndMortyAPI.Objects.Info.typename,
              "count": count,
              "next": next,
              "pages": pages,
              "prev": prev,
            ],
            fulfilledFragments: [
              ObjectIdentifier(LocationsQuery.Data.Locations.Info.self)
            ]
          ))
        }
      }

      /// Locations.Result
      ///
      /// Parent Type: `Location`
      public struct Result: RickAndMortyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Location }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("dimension", String?.self),
          .field("id", RickAndMortyAPI.ID?.self),
          .field("name", String?.self),
          .field("type", String?.self),
        ] }

        /// The dimension in which the location is located.
        public var dimension: String? { __data["dimension"] }
        /// The id of the location.
        public var id: RickAndMortyAPI.ID? { __data["id"] }
        /// The name of the location.
        public var name: String? { __data["name"] }
        /// The type of the location.
        public var type: String? { __data["type"] }

        public init(
          dimension: String? = nil,
          id: RickAndMortyAPI.ID? = nil,
          name: String? = nil,
          type: String? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": RickAndMortyAPI.Objects.Location.typename,
              "dimension": dimension,
              "id": id,
              "name": name,
              "type": type,
            ],
            fulfilledFragments: [
              ObjectIdentifier(LocationsQuery.Data.Locations.Result.self)
            ]
          ))
        }
      }
    }
  }
}
