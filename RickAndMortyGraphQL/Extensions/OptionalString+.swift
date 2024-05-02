//
//  OptionalString+.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import Foundation

extension Optional where Wrapped == String {
    /// A convienence method that returns the wrapped value, or the specified defaultValue.
    /// - Returns: The unwrapped optional if the value exists, or the specified value.
    /// Defaults to "unknown"
    func orDefault(_ defaultValue: String = "Unknown") -> String {
        return self ?? defaultValue
    }
}
