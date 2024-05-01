// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetAllCharactersQuery: GraphQLQuery {
  public static let operationName: String = "GetAllCharacters"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetAllCharacters { characters { __typename info { __typename count pages next prev } results { __typename id name species image status gender type created location { __typename id name } origin { __typename id name } episode { __typename id name air_date } } } }"#
    ))

  public init() {}

  public struct Data: RickAndMortyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("characters", Characters?.self),
    ] }

    /// Get the list of all characters
    public var characters: Characters? { __data["characters"] }

    /// Characters
    ///
    /// Parent Type: `Characters`
    public struct Characters: RickAndMortyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Characters }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("info", Info?.self),
        .field("results", [Result?]?.self),
      ] }

      public var info: Info? { __data["info"] }
      public var results: [Result?]? { __data["results"] }

      /// Characters.Info
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

      /// Characters.Result
      ///
      /// Parent Type: `Character`
      public struct Result: RickAndMortyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Character }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", RickAndMortyAPI.ID?.self),
          .field("name", String?.self),
          .field("species", String?.self),
          .field("image", String?.self),
          .field("status", String?.self),
          .field("gender", String?.self),
          .field("type", String?.self),
          .field("created", String?.self),
          .field("location", Location?.self),
          .field("origin", Origin?.self),
          .field("episode", [Episode?].self),
        ] }

        /// The id of the character.
        public var id: RickAndMortyAPI.ID? { __data["id"] }
        /// The name of the character.
        public var name: String? { __data["name"] }
        /// The species of the character.
        public var species: String? { __data["species"] }
        /// Link to the character's image.
        /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
        public var image: String? { __data["image"] }
        /// The status of the character ('Alive', 'Dead' or 'unknown').
        public var status: String? { __data["status"] }
        /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
        public var gender: String? { __data["gender"] }
        /// The type or subspecies of the character.
        public var type: String? { __data["type"] }
        /// Time at which the character was created in the database.
        public var created: String? { __data["created"] }
        /// The character's last known location
        public var location: Location? { __data["location"] }
        /// The character's origin location
        public var origin: Origin? { __data["origin"] }
        /// Episodes in which this character appeared.
        public var episode: [Episode?] { __data["episode"] }

        /// Characters.Result.Location
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
          ] }

          /// The id of the location.
          public var id: RickAndMortyAPI.ID? { __data["id"] }
          /// The name of the location.
          public var name: String? { __data["name"] }
        }

        /// Characters.Result.Origin
        ///
        /// Parent Type: `Location`
        public struct Origin: RickAndMortyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Location }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", RickAndMortyAPI.ID?.self),
            .field("name", String?.self),
          ] }

          /// The id of the location.
          public var id: RickAndMortyAPI.ID? { __data["id"] }
          /// The name of the location.
          public var name: String? { __data["name"] }
        }

        /// Characters.Result.Episode
        ///
        /// Parent Type: `Episode`
        public struct Episode: RickAndMortyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Episode }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", RickAndMortyAPI.ID?.self),
            .field("name", String?.self),
            .field("air_date", String?.self),
          ] }

          /// The id of the episode.
          public var id: RickAndMortyAPI.ID? { __data["id"] }
          /// The name of the episode.
          public var name: String? { __data["name"] }
          /// The air date of the episode.
          public var air_date: String? { __data["air_date"] }
        }
      }
    }
  }
}
