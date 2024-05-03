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

    @NSManaged public var id: String
    @NSManaged public var characterID: String?
    @NSManaged public var gender: String?
    @NSManaged public var imageURLString: String?
    @NSManaged public var name: String?
    @NSManaged public var species: String?
    @NSManaged public var status: String?
    @NSManaged public var type: String?
    @NSManaged public var origin: OriginEntity?

}

extension CharacterEntity {
    func populate(from character: Character, to context: NSManagedObjectContext) {
        self.id = character.id
        self.characterID = character.characterID.orDefault()
        self.gender = character.gender
        self.imageURLString = character.imageURLString
        self.name = character.name
        self.species = character.species
        self.status = character.status
        self.type = character.type
        
        if let origin = character.origin {
            let originEntity = OriginEntity(context: context)
            originEntity.populate(from: origin)
            self.origin = OriginEntity(context: context)
        }
    }
}
