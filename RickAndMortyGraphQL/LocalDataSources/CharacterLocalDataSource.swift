//
//  CharactersLocalDataSource.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import Factory
import Foundation
import CoreData

protocol CharactersLocalDataSource {
    func saveCharacters(_ characters: [Character]) async throws
    func fetchCharacters() async throws -> [Character]
}

final class CharactersLocalRepo: CharactersLocalDataSource {
    @Injected(\.coreDataStack) private var coreDataStack
    
    func saveCharacters(_ characters: [Character]) async throws {
        log("Saving characters", .debug, .persistence)
        let context = coreDataStack.newBackgroundContext()
        let existingCharacters = try await self.fetchExistingCharacters(in: context)
        let existingIds = Set(existingCharacters.keys)
        var newIds = Set<String>()
        
        try await context.perform {
            // Process new characters and track their IDs
            for character in characters {
                newIds.insert(character.id)
                if let existingCharacter = existingCharacters[character.id] {
                    // Update existing character
                    existingCharacter.populate(from: character, to: context)
                } else {
                    // Insert new character
                    let newEntity = CharacterEntity(context: context)
                    newEntity.populate(from: character, to: context)
                }
                try context.save()
            }
        }
        
        // Delete invalid entities
        let idsToDelete = existingIds.subtracting(newIds)
        for id in idsToDelete {
            try await deleteCharacter(byId: id)
        }
    }
    
    func fetchCharacters() async throws -> [Character] {
        log("Fetching characters", .debug, .persistence)
        let context = coreDataStack.viewContext
        return try await context.perform {
            let request: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
            let entities = try context.fetch(request)
            return entities.map { Character(fromEntity: $0) }
        }
    }
    
    private func deleteCharacter(byId id: String) async throws {
        log("Deleting character with id: \(id)", .debug, .persistence)
        let context = coreDataStack.newBackgroundContext()
        return try await context.perform {
            let request: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", id)
            let results = try context.fetch(request)
            if let entityToDelete = results.first {
                context.delete(entityToDelete)
                try context.save()
                log("Deleted outdated character", .info, .persistence)
            }
        }
    }
    
    private func fetchExistingCharacters(in context: NSManagedObjectContext) async throws -> [String: CharacterEntity] {
        log("Fetching existing characters", .debug, .persistence)
        return try await context.perform {
            let request: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
            let entities = try context.fetch(request)
            return Dictionary<String, CharacterEntity>(
                uniqueKeysWithValues: entities.compactMap { entity in
                    return (entity.id, entity)
                })
        }
    }
    
    enum CharactersLocalDataSourceError: Error {
        case characterNotFound
    }
}

extension Character {
    init(fromEntity entity: CharacterEntity) {
        self.init(
            characterID: entity.characterID,
            gender: entity.gender.orDefault(),
            imageURLString: entity.imageURLString,
            name: entity.name.orDefault(),
            origin: entity.origin.map { Origin(fromEntity: $0) },
            species: entity.species.orDefault(),
            status: entity.status.orDefault(),
            type: entity.type.orDefault()
        )
    }
}

extension Origin {
    init(fromEntity entity: OriginEntity) {
        self.init(
            dimension: entity.dimension.orDefault(),
            name: entity.name.orDefault(),
            type: entity.type.orDefault()
        )
    }
}
