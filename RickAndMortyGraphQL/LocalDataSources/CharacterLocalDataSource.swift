//
//  CharactersLocalDataSource.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import Factory
import Foundation
import CoreData

protocol CharacterLocalDataSource {
    func saveCharacters(_ characters: [Character]) async throws
    func fetchCharacters() async throws -> [Character]
}

// TODO: - Impliment with new models.
final class CharactersLocalRepo: CharacterLocalDataSource {
    @Injected(\.coreDataStack) private var coreDataStack

    func saveCharacters(_ characters: [Character]) async throws {
//        let context = coreDataStack.newBackgroundContext()
//        try await context.perform {
//            for character in characters {
//                let entity = CharacterEntity(context: context)
//                entity.populate(fromModel: character, in: context)
//            }
//            try context.save()
//        }
        fatalError("Unemplemented")
    }

    func fetchCharacters() async throws -> [Character] {
//        let context = coreDataStack.viewContext
//        let request: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
//        let entities = try context.fetch(request)
//        return entities.map { Character(fromEntity: $0) }
        fatalError("Unemplemented")
    }
}
