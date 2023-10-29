//
//  MoviesQueriesRepository.swift
//  Movies
//
//  Created by wonki on 10/23/23.
//

import Foundation

protocol MoviesQueriesRepository {
    func fetchRecentsQueries(
        maxCount: Int
    ) async throws -> MovieQuery
    
    @discardableResult
    func saveRecentQuery(
        query: MovieQuery
    ) async throws -> MovieQuery
}
