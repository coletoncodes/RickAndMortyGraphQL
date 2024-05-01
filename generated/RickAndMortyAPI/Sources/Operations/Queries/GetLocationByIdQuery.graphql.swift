// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetLocationByIdQuery: GraphQLQuery {
  public static let operationName: String = "GetLocationById"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetLocationById($id: ID!) { location(id: $id) { __typename id name type dimension created residents { __typename id name image } } }"#
    ))

  public var id: ID

  public init(id: ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: RickAndMortyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("location", Location?.self, arguments: ["id": .variable("id")]),
    ] }

    /// Get a specific locations by ID
    public var location: Location? { __data["location"] }

    /// Location
    ///
    /// Parent Type: `Location`
    public struct Location: RickAndMortyAPI.SelectionSet {
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

      /// Location.Resident
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
