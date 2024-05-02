//
//  LocationEntity+CoreDataClass.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//
//

import Foundation
import CoreData

@objc(LocationEntity)
public class LocationEntity: NSManagedObject {
    func populate(fromModel model: Location, in context: NSManagedObjectContext) {
        self.id = model.id
        self.name = model.name
        self.type = model.type
        self.dimension = model.dimension
        self.createdAt = model.createdAt
        
        // Manage relationships
        updateOriginatedCharacters(with: model.originatedCharacters, in: context)
        updateResidents(with: model.currentResidents, in: context)
    }
    
    private func updateOriginatedCharacters(with newCharacters: [Character], in context: NSManagedObjectContext) {
        // Assuming CharacterEntity includes an identifier or can uniquely be identified
        guard let originatedCharacters = self.originatedCharacters as? Set<CharacterEntity> else { return }
        
        let newCharacterIDs = Set(newCharacters.map { $0.id })
        let existingCharacterIDs = Set(originatedCharacters.map { $0.id })
        
        // Characters to be removed
        let charactersToRemove = originatedCharacters.filter { !newCharacterIDs.contains($0.id) }
        charactersToRemove.forEach { self.removeFromOriginatedCharacters($0) }
        
        // Characters to be added
        newCharacters.forEach { character in
            if !existingCharacterIDs.contains(character.id) {
                if let characterEntity = NSEntityDescription.insertNewObject(forEntityName: "CharacterEntity", into: context) as? CharacterEntity {
                    characterEntity.populate(fromModel: character, in: context)
                    self.addToOriginatedCharacters(characterEntity)
                }
            }
        }
    }
    
    private func updateResidents(with newResidents: [Character], in context: NSManagedObjectContext) {
        guard let residents = self.residents as? Set<CharacterEntity> else { return }
        
        let newResidentIDs = Set(newResidents.map { $0.id })
        let existingResidentIDs = Set(residents.map { $0.id })
        
        // Residents to be removed
        let residentsToRemove = residents.filter { !newResidentIDs.contains($0.id) }
        residentsToRemove.forEach { self.removeFromResidents($0) }
        
        // Residents to be added
        newResidents.forEach { resident in
            if !existingResidentIDs.contains(resident.id) {
                if let residentEntity = NSEntityDescription.insertNewObject(forEntityName: "CharacterEntity", into: context) as? CharacterEntity {
                    residentEntity.populate(fromModel: resident, in: context)
                    self.addToResidents(residentEntity)
                }
            }
        }
    }
}
