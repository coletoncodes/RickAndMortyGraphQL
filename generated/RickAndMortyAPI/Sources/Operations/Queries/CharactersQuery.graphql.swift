// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CharactersQuery: GraphQLQuery {
  public static let operationName: String = "Characters"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Characters($page: Int) { characters(page: $page) { __typename info { __typename count next pages prev } results { __typename gender id image status type species name origin { __typename name dimension type } } } }"#
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
      .field("characters", Characters?.self, arguments: ["page": .variable("page")]),
    ] }

    /// Get the list of all characters
    public var characters: Characters? { __data["characters"] }

    public init(
      characters: Characters? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": RickAndMortyAPI.Objects.Query.typename,
          "characters": characters._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(CharactersQuery.Data.self)
        ]
      ))
    }

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

      public init(
        info: Info? = nil,
        results: [Result?]? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": RickAndMortyAPI.Objects.Characters.typename,
            "info": info._fieldData,
            "results": results._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(CharactersQuery.Data.Characters.self)
          ]
        ))
      }

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
              ObjectIdentifier(CharactersQuery.Data.Characters.Info.self)
            ]
          ))
        }
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
          .field("gender", String?.self),
          .field("id", RickAndMortyAPI.ID?.self),
          .field("image", String?.self),
          .field("status", String?.self),
          .field("type", String?.self),
          .field("species", String?.self),
          .field("name", String?.self),
          .field("origin", Origin?.self),
        ] }

        /// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
        public var gender: String? { __data["gender"] }
        /// The id of the character.
        public var id: RickAndMortyAPI.ID? { __data["id"] }
        /// Link to the character's image.
        /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
        public var image: String? { __data["image"] }
        /// The status of the character ('Alive', 'Dead' or 'unknown').
        public var status: String? { __data["status"] }
        /// The type or subspecies of the character.
        public var type: String? { __data["type"] }
        /// The species of the character.
        public var species: String? { __data["species"] }
        /// The name of the character.
        public var name: String? { __data["name"] }
        /// The character's origin location
        public var origin: Origin? { __data["origin"] }

        public init(
          gender: String? = nil,
          id: RickAndMortyAPI.ID? = nil,
          image: String? = nil,
          status: String? = nil,
          type: String? = nil,
          species: String? = nil,
          name: String? = nil,
          origin: Origin? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": RickAndMortyAPI.Objects.Character.typename,
              "gender": gender,
              "id": id,
              "image": image,
              "status": status,
              "type": type,
              "species": species,
              "name": name,
              "origin": origin._fieldData,
            ],
            fulfilledFragments: [
              ObjectIdentifier(CharactersQuery.Data.Characters.Result.self)
            ]
          ))
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
            .field("name", String?.self),
            .field("dimension", String?.self),
            .field("type", String?.self),
          ] }

          /// The name of the location.
          public var name: String? { __data["name"] }
          /// The dimension in which the location is located.
          public var dimension: String? { __data["dimension"] }
          /// The type of the location.
          public var type: String? { __data["type"] }

          public init(
            name: String? = nil,
            dimension: String? = nil,
            type: String? = nil
          ) {
            self.init(_dataDict: DataDict(
              data: [
                "__typename": RickAndMortyAPI.Objects.Location.typename,
                "name": name,
                "dimension": dimension,
                "type": type,
              ],
              fulfilledFragments: [
                ObjectIdentifier(CharactersQuery.Data.Characters.Result.Origin.self)
              ]
            ))
          }
        }
      }
    }
  }
}
