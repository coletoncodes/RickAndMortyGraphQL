//
//  log.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/1/24.
//

import Foundation
import OSLog
import CCLogging

/// The global logging function used in this target.
func log(
    _ message: String,
    _ osLogType: OSLogType = .debug,
    _ category: CCLogCategory,
    function: String = #function,
    line: Int = #line,
    file: String = #file
) {
    logger.log(message, osLogType, category, function: function, line: line, file: file)
}
