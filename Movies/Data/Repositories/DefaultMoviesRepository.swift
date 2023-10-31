//
//  DefaultMoviesRepository.swift
//  Movies
//
//  Created by wonki on 10/31/23.
//

import Foundation

final class DefaultMoviesRepository {
    
    private let dataTransferService: DataTransferService
    private let cache: MoviesResponseStorage
    
    init(dataTransferService: DataTransferService, cache: MoviesResponseStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}

extension DefaultMoviesRepository: MoviesRepository {
    func fetchMoviesList(query: MovieQuery, page: Int) async throws -> (cached: Bool, MoviesPage) {
        
        let requestDTO = MoviesRequestDTO(query: query.query, page: page)
        
        // TODO: 캐시 구현
//        let cacheResult = try await cache.getResponse(for: requestDTO)
//        if let cacheResult {
//            return (true, cacheResult.toDomain())
//        }
        
        let endpoint = APIEndpoints.getMovies(with: requestDTO)
        let apiResult = try! await dataTransferService.request(
            with: endpoint)
        return (false, apiResult.toDomain())
    }
}
