//
//  Paged.swift
//  RickAndMortyGraphQL
//
//  Created by Coleton Gorecke on 5/2/24.
//

import Foundation

struct PageInfo: Codable {
    var currentPage: Int?
    var totalPages: Int?
    
    init(
        currentPage: Int?,
        totalPages: Int?
    ) {
        self.currentPage = currentPage
        self.totalPages = totalPages
    }
}

/// A generic class that encapsulates a paginated data model
/// and the mechanism to fetch subsequent pages.
/// It holds an array of data items of type `DataModel`
/// and a closure that can asynchronously fetch the next page.
actor Paged<DataModel> {
    /// The current page's data
    private(set) var data: [DataModel]
    
    /// The page info for this object.
    private(set) var pageInfo: PageInfo
    
    /// A closure that, when executed, will asynchronously fetch the next page of data.
    /// This closure is `nil` if there are no more pages to fetch.
    private let fetchPage: (Int) async throws -> Paged<DataModel>
    
    /// Initializes a new instance of the `Paged` class with the given data
    /// and an optional closure to fetch the next page.
    /// - Parameters:
    ///   - data: The current page of data as an array of `DataModel`.
    ///   - fetchPage: An optional closure that fetches the next page of data for the given page number.
    ///     It returns an instance of `Paged<DataModel>`
    ///     or throws an error if unable to fetch the next page. Defaults to `nil`.
    ///   - pageInfo: The initial ``PageInfo`` for this object.
    init(
        data: [DataModel],
        pageInfo: PageInfo,
        fetchPage: @escaping (Int) async throws -> Paged<DataModel>
    ) {
        self.data = data
        self.pageInfo = pageInfo
        self.fetchPage = fetchPage
    }
    
    /// Updates the objects data with the results of the nextPageFetcher, if it exists.
    /// Otherwise an error is thrown.
    /// - Throws: An error if there is an issue fetching the next page of data,
    ///     or no new data exists.
    func fetchNextPage() async throws {
        guard let currentPage = pageInfo.currentPage,
              let totalPages = pageInfo.totalPages,
              currentPage < totalPages
        else {
            throw PagedError.noNextPage
        }
        
        let newData = try await fetchPage(currentPage + 1)
        data += await newData.data
        pageInfo = await newData.pageInfo
    }
    
    /// Errors thrown from a ``Paged`` object.
    enum PagedError: Error {
        /// No next page was available
        case noNextPage
    }
}
