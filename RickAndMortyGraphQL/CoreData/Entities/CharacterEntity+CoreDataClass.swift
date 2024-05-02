//
//  CharacterEntity+CoreDataClass.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//
//

import Foundation
import CoreData

@objc(CharacterEntity)
public class CharacterEntity: NSManagedObject {
    func populate(fromModel model: Character, in context: NSManagedObjectContext) {
        self.id = model.id
        self.createdAt = model.createdAt
        self.gender = model.gender
        self.imageURLString = model.imageURLString
        self.name = model.name
        self.species = model.species
        self.status = model.status
        self.type = model.type
        
        // Handle episodes relationship
        updateEpisodes(with: model.episodes, in: context)
        
        // Handle last known location
        updateLastKnownLocation(with: model.lastKnownLocation, in: context)
        
        // handle origin
        updateOriginLocation(with: model.origin, in: context)
    }
    
    private func updateEpisodes(with newEpisodes: [Episode], in context: NSManagedObjectContext) {
        guard let context = self.managedObjectContext else { return }
        // Assuming EpisodeEntity has an identifier or a unique way to match episodes
        let newEpisodeIDs = Set(newEpisodes.map { $0.id })
        
        // Fetch existing episodes
        let existingEpisodes = (self.episodes as? Set<EpisodeEntity>) ?? []
        let existingEpisodeIDs = Set(existingEpisodes.map { $0.id })
        
        // Determine episodes to remove
        let episodesToRemove = existingEpisodes.filter { !newEpisodeIDs.contains($0.id) }
        episodesToRemove.forEach { self.removeFromEpisodes($0) }
        
        // Determine episodes to add
        newEpisodes.forEach { episode in
            if !existingEpisodeIDs.contains(episode.id) {
                if let newEpisodeEntity = NSEntityDescription.insertNewObject(forEntityName: "EpisodeEntity", into: context) as? EpisodeEntity {
                    newEpisodeEntity.populate(fromModel: episode, in: context)
                    self.addToEpisodes(newEpisodeEntity)
                }
            }
        }
    }
    
    private func updateLastKnownLocation(with newLocation: Location?, in context: NSManagedObjectContext) {
        // Create or update the location entity
        if let location = newLocation {
            // Check if existing location matches the new one, update or create new
            if let currentLocation = self.lastKnownLocation, currentLocation.id == location.id {
                currentLocation.populate(fromModel: location, in: context)
            } else {
                if let newLocationEntity = NSEntityDescription.insertNewObject(forEntityName: "LocationEntity", into: context) as? LocationEntity {
                    newLocationEntity.populate(fromModel: location, in: context)
                    self.lastKnownLocation = newLocationEntity
                }
            }
        } else {
            self.lastKnownLocation = nil // Clear if no location provided
        }
    }
    
    private func updateOriginLocation(with newOrigin: Location?, in context: NSManagedObjectContext) {
        guard let context = self.managedObjectContext else { return }
        // Create or update the location entity
        if let origin = newOrigin {
            // Check if existing location matches the new one, update or create new
            if let currentOrigin = self.origin, currentOrigin.id == origin.id {
                currentOrigin.populate(fromModel: origin, in: context)
            } else {
                if let newOriginEntity = NSEntityDescription.insertNewObject(forEntityName: "LocationEntity", into: context) as? LocationEntity {
                    newOriginEntity.populate(fromModel: origin, in: context)
                    self.lastKnownLocation = newOriginEntity
                }
            }
        } else {
            self.origin = nil // Clear if no location provided
        }
    }
}
