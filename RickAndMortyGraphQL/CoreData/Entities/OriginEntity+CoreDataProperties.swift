//
//  OriginEntity+CoreDataProperties.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//
//

import Foundation
import CoreData


extension OriginEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OriginEntity> {
        return NSFetchRequest<OriginEntity>(entityName: "OriginEntity")
    }

    @NSManaged public var dimension: String?
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var characters: NSSet?

}

// MARK: Generated accessors for character
extension OriginEntity {

    @objc(addCharacterObject:)
    @NSManaged public func addToCharacter(_ value: CharacterEntity)

    @objc(removeCharacterObject:)
    @NSManaged public func removeFromCharacter(_ value: CharacterEntity)

    @objc(addCharacter:)
    @NSManaged public func addToCharacter(_ values: NSSet)

    @objc(removeCharacter:)
    @NSManaged public func removeFromCharacter(_ values: NSSet)

}

extension OriginEntity {
    func populate(from origin: Origin) {
        self.dimension = origin.dimension
        self.name = origin.name
        self.type = origin.name
    }
}
