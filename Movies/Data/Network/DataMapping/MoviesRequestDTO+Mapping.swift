//
//  MoviesRequestDTO+Mapping.swift
//  Movies
//
//  Created by wonki on 10/31/23.
//

import Foundation

struct MoviesRequestDTO: Encodable {
    let query: String
    let page: Int
}
