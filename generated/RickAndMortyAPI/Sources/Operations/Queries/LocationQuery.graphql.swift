// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class LocationQuery: GraphQLQuery {
  public static let operationName: String = "Location"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Location($locationId: ID!) { location(id: $locationId) { __typename residents { __typename id image name species status } } }"#
    ))

  public var locationId: ID

  public init(locationId: ID) {
    self.locationId = locationId
  }

  public var __variables: Variables? { ["locationId": locationId] }

  public struct Data: RickAndMortyAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("location", Location?.self, arguments: ["id": .variable("locationId")]),
    ] }

    /// Get a specific locations by ID
    public var location: Location? { __data["location"] }

    public init(
      location: Location? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": RickAndMortyAPI.Objects.Query.typename,
          "location": location._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(LocationQuery.Data.self)
        ]
      ))
    }

    /// Location
    ///
    /// Parent Type: `Location`
    public struct Location: RickAndMortyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { RickAndMortyAPI.Objects.Location }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("residents", [Resident?].self),
      ] }

      /// List of characters who have been last seen in the location.
      public var residents: [Resident?] { __data["residents"] }

      public init(
        residents: [Resident?]
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": RickAndMortyAPI.Objects.Location.typename,
            "residents": residents._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(LocationQuery.Data.Location.self)
          ]
        ))
      }

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
          .field("image", String?.self),
          .field("name", String?.self),
          .field("species", String?.self),
          .field("status", String?.self),
        ] }

        /// The id of the character.
        public var id: RickAndMortyAPI.ID? { __data["id"] }
        /// Link to the character's image.
        /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
        public var image: String? { __data["image"] }
        /// The name of the character.
        public var name: String? { __data["name"] }
        /// The species of the character.
        public var species: String? { __data["species"] }
        /// The status of the character ('Alive', 'Dead' or 'unknown').
        public var status: String? { __data["status"] }

        public init(
          id: RickAndMortyAPI.ID? = nil,
          image: String? = nil,
          name: String? = nil,
          species: String? = nil,
          status: String? = nil
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": RickAndMortyAPI.Objects.Character.typename,
              "id": id,
              "image": image,
              "name": name,
              "species": species,
              "status": status,
            ],
            fulfilledFragments: [
              ObjectIdentifier(LocationQuery.Data.Location.Resident.self)
            ]
          ))
        }
      }
    }
  }
}
