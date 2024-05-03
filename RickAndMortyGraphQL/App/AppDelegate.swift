//
//  AppDelegate.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import UIKit
import Factory
import Foundation

let isRunningInSwiftUIPreviewMode: Bool = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"

class AppDelegate: NSObject, UIApplicationDelegate {
    @Injected(\.coreDataStack) private var coreDataStack
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        if isRunningInSwiftUIPreviewMode { return true }
        log("App launched", .info, .default)
        let persistentContainer = coreDataStack.persistentContainer
        log("Created persistent container: \(persistentContainer.description)", .info, .default)
        return true
    }
}
