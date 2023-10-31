//
//  DefaultMoviesQueriesRepository.swift
//  Movies
//
//  Created by wonki on 10/31/23.
//

import Foundation

final class DefaultMoviesQueriesRepository {
    
    init() {}
    
}

extension DefaultMoviesQueriesRepository: MoviesQueriesRepository {
    func fetchRecentsQueries(maxCount: Int) async throws -> MovieQuery {
        return MovieQuery(query: "")
    }
    
    func saveRecentQuery(query: MovieQuery) async throws -> MovieQuery {
        return query
    }
}
