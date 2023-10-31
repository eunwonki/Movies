//
//  MoviesResoponseEntity+Mapping.swift
//  Movies
//
//  Created by wonki on 10/31/23.
//

import Foundation

extension MoviesResponseEntity {
    func toDTO() -> MoviesResponseDTO {
        return .init(
            page: Int(page),
            totalPages: Int(totalPages),
            movies: movies?.allObjects.map {
                (($0) as! MovieResponseEntity).toDTO()
            } ?? [])
    }
}

extension MovieResponseEntity {
    func toDTO() -> MoviesResponseDTO.MovieDTO {
        return .init(
            id: Int(id),
            title: title,
            genre: .init(rawValue: genre ?? ""),
            posterPath: posterPath,
            overview: overview,
            releaseDate: releaseDate
        )
    }
}
