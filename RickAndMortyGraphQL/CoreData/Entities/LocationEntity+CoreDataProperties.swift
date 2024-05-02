//
//  LocationEntity+CoreDataProperties.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//
//

import Foundation
import CoreData


extension LocationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocationEntity> {
        return NSFetchRequest<LocationEntity>(entityName: "LocationEntity")
    }

    @NSManaged public var createdAt: String
    @NSManaged public var dimension: String
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var originatedCharacters: NSSet
    @NSManaged public var residents: NSSet

}

// MARK: Generated accessors for originatedCharacters
extension LocationEntity {

    @objc(addOriginatedCharactersObject:)
    @NSManaged public func addToOriginatedCharacters(_ value: CharacterEntity)

    @objc(removeOriginatedCharactersObject:)
    @NSManaged public func removeFromOriginatedCharacters(_ value: CharacterEntity)

    @objc(addOriginatedCharacters:)
    @NSManaged public func addToOriginatedCharacters(_ values: NSSet)

    @objc(removeOriginatedCharacters:)
    @NSManaged public func removeFromOriginatedCharacters(_ values: NSSet)

}

// MARK: Generated accessors for residents
extension LocationEntity {

    @objc(addResidentsObject:)
    @NSManaged public func addToResidents(_ value: CharacterEntity)

    @objc(removeResidentsObject:)
    @NSManaged public func removeFromResidents(_ value: CharacterEntity)

    @objc(addResidents:)
    @NSManaged public func addToResidents(_ values: NSSet)

    @objc(removeResidents:)
    @NSManaged public func removeFromResidents(_ values: NSSet)

}

extension LocationEntity : Identifiable {

}
