//
//  CharacterEntity+CoreDataProperties.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//
//

import Foundation
import CoreData


extension CharacterEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterEntity> {
        return NSFetchRequest<CharacterEntity>(entityName: "CharacterEntity")
    }

    @NSManaged public var createdAt: String
    @NSManaged public var gender: String
    @NSManaged public var id: String
    @NSManaged public var imageURLString: String
    @NSManaged public var name: String
    @NSManaged public var species: String
    @NSManaged public var status: String
    @NSManaged public var type: String
    @NSManaged public var episodes: NSSet
    @NSManaged public var origin: LocationEntity?
    @NSManaged public var lastKnownLocation: LocationEntity?

}

// MARK: Generated accessors for episodes
extension CharacterEntity {

    @objc(addEpisodesObject:)
    @NSManaged public func addToEpisodes(_ value: EpisodeEntity)

    @objc(removeEpisodesObject:)
    @NSManaged public func removeFromEpisodes(_ value: EpisodeEntity)

    @objc(addEpisodes:)
    @NSManaged public func addToEpisodes(_ values: NSSet)

    @objc(removeEpisodes:)
    @NSManaged public func removeFromEpisodes(_ values: NSSet)

}

extension CharacterEntity : Identifiable {

}
