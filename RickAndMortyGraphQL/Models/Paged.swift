//
//  Paged.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import Foundation

/// A generic class that encapsulates a paginated data model
/// and the mechanism to fetch subsequent pages.
/// It holds an array of data items of type `DataModel`
/// and a closure that can asynchronously fetch the next page.
actor Paged<DataModel> {
    /// The current page's data
    private(set) var data: [DataModel]
    
    /// A closure that, when executed, will asynchronously fetch the next page of data.
    /// This closure is `nil` if there are no more pages to fetch.
    private var nextPageFetcher: (() async throws -> Paged<DataModel>)?
    
    /// Initializes a new instance of the `Paged` class with the given data
    /// and an optional closure to fetch the next page.
    /// - Parameters:
    ///   - data: The current page of data as an array of `DataModel`.
    ///   - nextPageFetcher: An optional closure that fetches the next page of data.
    ///     It returns an instance of `Paged<DataModel>`
    ///     or throws an error if unable to fetch the next page. Defaults to `nil`.
    init(
        data: [DataModel],
        nextPageFetcher: (() async throws -> Paged<DataModel>)? = nil
    ) {
        self.data = data
        self.nextPageFetcher = nextPageFetcher
    }
    
    /// Updates the objects data with the results of the nextPageFetcher, if it exists.
    /// Otherwise an error is thrown.
    /// - Throws: An error if there is an issue fetching the next page of data,
    ///     or no new data exists.
    func fetchNextPage() async throws {
        guard let nextPageFetcher = nextPageFetcher else {
            log("No next page to fetch", .error, .persistence)
            throw PagedError.noNextPage
        }
        
        do {
            let newPageData = try await nextPageFetcher()
            await data += newPageData.data
            self.nextPageFetcher = await newPageData.nextPageFetcher
        } catch {
            let errorStr = "Failed to fetch next page with error: \(error)"
            log(errorStr, .error, .networking)
            throw PagedError.fetchNextPageError(errorStr)
        }
    }
    
    /// Errors thrown from a ``Paged`` object.
    enum PagedError: Error {
        /// No next page was available
        case noNextPage
        /// An error occurred when attempting to fetch the next page.
        case fetchNextPageError(String)
    }
}
