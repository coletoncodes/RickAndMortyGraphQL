//
//  EpisodeEntity+CoreDataClass.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//
//

import Foundation
import CoreData

@objc(EpisodeEntity)
public class EpisodeEntity: NSManagedObject {
    func populate(fromModel model: Episode, in context: NSManagedObjectContext) {
        self.id = model.id
        self.airDate = model.airDate
        self.createdAt = model.createdAt
        self.episodeCode = model.episodeCode
        self.name = model.name
        
        // Manage characters relationship
        updateCharacters(with: model.characters, in: context)
    }
    
    private func updateCharacters(with newCharacters: [Character], in context: NSManagedObjectContext) {
        // Convert existing NSSet of characters to a set of CharacterEntity for easier comparison
        let existingCharacters = self.characters as? Set<CharacterEntity> ?? []
        
        // Create a set with new character IDs for comparison
        let newCharacterIDs = Set(newCharacters.map { $0.id })
        
        // Determine characters to remove
        let charactersToRemove = existingCharacters.filter { !newCharacterIDs.contains($0.id) }
        for character in charactersToRemove {
            self.removeFromCharacters(character)
        }
        
        // Add new characters
        let existingCharacterIDs = Set(existingCharacters.map { $0.id })
        let charactersToAdd = newCharacters.filter { !existingCharacterIDs.contains($0.id) }
        for character in charactersToAdd {
            if let newCharacterEntity = NSEntityDescription.insertNewObject(forEntityName: "CharacterEntity", into: context) as? CharacterEntity {
                newCharacterEntity.populate(fromModel: character, in: context)
                self.addToCharacters(newCharacterEntity)
            }
        }
    }
}
