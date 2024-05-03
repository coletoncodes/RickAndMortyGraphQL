// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CharacterQuery: GraphQLQuery {
  public static let operationName: String = "Character"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Character($characterId: ID!) { character(id: $characterId) { __typename episode { __typename episode id name } location { __typename dimension id name type } } }"#
    ))

  public var characterId: ID

  public init(characterId: ID) {
    self.characterId = characterId
  }

  public var __variables: Variables? { ["characterId": characterId] }

  public struct Data: RickAndMortyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("character", Character?.self, arguments: ["id": .variable("characterId")]),
    ] }

    /// Get a specific character by ID
    public var character: Character? { __data["character"] }

    /// Character
    ///
    /// Parent Type: `Character`
    public struct Character: RickAndMortyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Character }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("episode", [Episode?].self),
        .field("location", Location?.self),
      ] }

      /// Episodes in which this character appeared.
      public var episode: [Episode?] { __data["episode"] }
      /// The character's last known location
      public var location: Location? { __data["location"] }

      /// Character.Episode
      ///
      /// Parent Type: `Episode`
      public struct Episode: RickAndMortyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Episode }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("episode", String?.self),
          .field("id", RickAndMortyAPI.ID?.self),
          .field("name", String?.self),
        ] }

        /// The code of the episode.
        public var episode: String? { __data["episode"] }
        /// The id of the episode.
        public var id: RickAndMortyAPI.ID? { __data["id"] }
        /// The name of the episode.
        public var name: String? { __data["name"] }
      }

      /// Character.Location
      ///
      /// Parent Type: `Location`
      public struct Location: RickAndMortyAPI.SelectionSet {
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
      }
    }
  }
}
