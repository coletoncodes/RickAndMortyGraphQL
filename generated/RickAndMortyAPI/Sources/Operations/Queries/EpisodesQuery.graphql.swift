// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class EpisodesQuery: GraphQLQuery {
  public static let operationName: String = "Episodes"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Episodes($page: Int) { episodes(page: $page) { __typename info { __typename count next pages prev } results { __typename air_date created episode name id } } }"#
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
      .field("episodes", Episodes?.self, arguments: ["page": .variable("page")]),
    ] }

    /// Get the list of all episodes
    public var episodes: Episodes? { __data["episodes"] }

    /// Episodes
    ///
    /// Parent Type: `Episodes`
    public struct Episodes: RickAndMortyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Episodes }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("info", Info?.self),
        .field("results", [Result?]?.self),
      ] }

      public var info: Info? { __data["info"] }
      public var results: [Result?]? { __data["results"] }

      /// Episodes.Info
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
      }

      /// Episodes.Result
      ///
      /// Parent Type: `Episode`
      public struct Result: RickAndMortyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Episode }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("air_date", String?.self),
          .field("created", String?.self),
          .field("episode", String?.self),
          .field("name", String?.self),
          .field("id", RickAndMortyAPI.ID?.self),
        ] }

        /// The air date of the episode.
        public var air_date: String? { __data["air_date"] }
        /// Time at which the episode was created in the database.
        public var created: String? { __data["created"] }
        /// The code of the episode.
        public var episode: String? { __data["episode"] }
        /// The name of the episode.
        public var name: String? { __data["name"] }
        /// The id of the episode.
        public var id: RickAndMortyAPI.ID? { __data["id"] }
      }
    }
  }
}
