//
//  Navigator.swift
//
//
//  Created by Coleton Gorecke on 4/26/24.
//

import Foundation
import SwiftUI

/// The principal Navigator class to be used inside ViewStack's. Subclass to instantiate various paths, or connect to either a View, or ViewModel to trigger navigation.
@MainActor
open class Navigator: ObservableObject {
    
    // MARK: - Initializer
    public required nonisolated init() {}
    
    // MARK: - Interface
    /// The current ``NavigationPath``
    @Published open var path = NavigationPath()
    
    /// Pushes a Hashable object onto the path.
    /// - Parameter destination: The Hashable Destination to push on to the stack
    open func push<H: Hashable>(destination: H) {
        path.append(destination)
    }
    
    /// Pop's the last pushed destination from the path.
    open func popLast() {
        guard !path.isEmpty else {
            log("Attempted to pop destination from path when path was empty", .fault, .viewModel)
            return
        }
        path.removeLast()
    }
    
    /// Completely resets the ``NavigationPath`` to empty.
    open func popToRoot() {
        path = NavigationPath()
    }
}
