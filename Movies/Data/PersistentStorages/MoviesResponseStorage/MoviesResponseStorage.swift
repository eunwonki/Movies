//
//  MoviesResponseStorage.swift
//  Movies
//
//  Created by wonki on 10/31/23.
//

import Foundation

protocol MoviesResponseStorage {
    func getResponse(
        for request: MoviesRequestDTO
    )
    async throws -> MoviesResponseDTO?
    
    func save(
        response: MoviesResponseDTO,
        for requestDto: MoviesRequestDTO
    )
}
