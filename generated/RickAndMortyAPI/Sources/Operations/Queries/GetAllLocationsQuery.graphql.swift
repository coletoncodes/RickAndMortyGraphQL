// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetAllLocationsQuery: GraphQLQuery {
  public static let operationName: String = "GetAllLocations"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetAllLocations { locations { __typename info { __typename count pages next prev } results { __typename id name type dimension created residents { __typename id name image } } } }"#
    ))

  public init() {}

  public struct Data: RickAndMortyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("locations", Locations?.self),
    ] }

    /// Get the list of all locations
    public var locations: Locations? { __data["locations"] }

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
          .field("pages", Int?.self),
          .field("next", Int?.self),
          .field("prev", Int?.self),
        ] }

        /// The length of the response.
        public var count: Int? { __data["count"] }
        /// The amount of pages.
        public var pages: Int? { __data["pages"] }
        /// Number of the next page (if it exists)
        public var next: Int? { __data["next"] }
        /// Number of the previous page (if it exists)
        public var prev: Int? { __data["prev"] }
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
          .field("id", RickAndMortyAPI.ID?.self),
          .field("name", String?.self),
          .field("type", String?.self),
          .field("dimension", String?.self),
          .field("created", String?.self),
          .field("residents", [Resident?].self),
        ] }

        /// The id of the location.
        public var id: RickAndMortyAPI.ID? { __data["id"] }
        /// The name of the location.
        public var name: String? { __data["name"] }
        /// The type of the location.
        public var type: String? { __data["type"] }
        /// The dimension in which the location is located.
        public var dimension: String? { __data["dimension"] }
        /// Time at which the location was created in the database.
        public var created: String? { __data["created"] }
        /// List of characters who have been last seen in the location.
        public var residents: [Resident?] { __data["residents"] }

        /// Locations.Result.Resident
        ///
        /// Parent Type: `Character`
        public struct Resident: RickAndMortyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Character }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", RickAndMortyAPI.ID?.self),
            .field("name", String?.self),
            .field("image", String?.self),
          ] }

          /// The id of the character.
          public var id: RickAndMortyAPI.ID? { __data["id"] }
          /// The name of the character.
          public var name: String? { __data["name"] }
          /// Link to the character's image.
          /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
          public var image: String? { __data["image"] }
        }
      }
    }
  }
}
