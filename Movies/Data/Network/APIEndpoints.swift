//
//  APIEndpoints.swift
//  Movies
//
//  Created by wonki on 10/31/23.
//

import Foundation

struct APIEndpoints {
    
    static func getMovies(
        with moviesRequestDTO: MoviesRequestDTO
    ) -> Endpoint<MoviesResponseDTO> {
        
        return Endpoint(
            path: "3/search/movie",
            method: .get,
            queryParametersEncodable: moviesRequestDTO
        )
    }
    
}
