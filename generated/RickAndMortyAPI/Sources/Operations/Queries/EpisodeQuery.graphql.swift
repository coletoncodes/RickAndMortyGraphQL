// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class EpisodeQuery: GraphQLQuery {
  public static let operationName: String = "Episode"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Episode($episodeId: ID!) { episode(id: $episodeId) { __typename characters { __typename image name status } } }"#
    ))

  public var episodeId: ID

  public init(episodeId: ID) {
    self.episodeId = episodeId
  }

  public var __variables: Variables? { ["episodeId": episodeId] }

  public struct Data: RickAndMortyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("episode", Episode?.self, arguments: ["id": .variable("episodeId")]),
    ] }

    /// Get a specific episode by ID
    public var episode: Episode? { __data["episode"] }

    public init(
      episode: Episode? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": RickAndMortyAPI.Objects.Query.typename,
          "episode": episode._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(EpisodeQuery.Data.self)
        ]
      ))
    }

    /// Episode
    ///
    /// Parent Type: `Episode`
    public struct Episode: RickAndMortyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Episode }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("characters", [Character?].self),
      ] }

      /// List of characters who have been seen in the episode.
      public var characters: [Character?] { __data["characters"] }

      public init(
        characters: [Character?]
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": RickAndMortyAPI.Objects.Episode.typename,
            "characters": characters._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(EpisodeQuery.Data.Episode.self)
          ]
        ))
      }

      /// Episode.Character
      ///
      /// Parent Type: `Character`
      public struct Character: RickAndMortyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Character }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("image", String?.self),
          .field("name", String?.self),
          .field("status", String?.self),
        ] }

        /// Link to the character's image.
        /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
        public var image: String? { __data["image"] }
        /// The name of the character.
        public var name: String? { __data["name"] }
        /// The status of the character ('Alive', 'Dead' or 'unknown').
        public var status: String? { __data["status"] }

        public init(
          image: String? = nil,
          name: String? = nil,
          status: String? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": RickAndMortyAPI.Objects.Character.typename,
              "image": image,
              "name": name,
              "status": status,
            ],
            fulfilledFragments: [
              ObjectIdentifier(EpisodeQuery.Data.Episode.Character.self)
            ]
          ))
        }
      }
    }
  }
}
