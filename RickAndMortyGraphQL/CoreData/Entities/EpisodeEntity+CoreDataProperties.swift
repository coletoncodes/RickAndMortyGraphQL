//
//  EpisodeEntity+CoreDataProperties.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//
//

import Foundation
import CoreData


extension EpisodeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EpisodeEntity> {
        return NSFetchRequest<EpisodeEntity>(entityName: "EpisodeEntity")
    }

    @NSManaged public var airDate: String
    @NSManaged public var created: String
    @NSManaged public var episodeCode: String
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var characters: NSSet

}

// MARK: Generated accessors for characters
extension EpisodeEntity {

    @objc(addCharactersObject:)
    @NSManaged public func addToCharacters(_ value: CharacterEntity)

    @objc(removeCharactersObject:)
    @NSManaged public func removeFromCharacters(_ value: CharacterEntity)

    @objc(addCharacters:)
    @NSManaged public func addToCharacters(_ values: NSSet)

    @objc(removeCharacters:)
    @NSManaged public func removeFromCharacters(_ values: NSSet)

}

extension EpisodeEntity : Identifiable {

}
