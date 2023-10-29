//
//  MoviesRepository.swift
//  Movies
//
//  Created by wonki on 10/23/23.
//

import Foundation

protocol MoviesRepository {
    func fetchMoviesList(
        query: MovieQuery,
        page: Int
    ) async throws -> (cached: Bool, MoviesPage)
}
