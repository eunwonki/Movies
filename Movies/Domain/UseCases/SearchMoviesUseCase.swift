//
//  SearchMoviesUseCase.swift
//  Movies
//
//  Created by wonki on 10/23/23.
//

import Foundation

protocol SearchMoviesUseCase {
    // 음 UseCase는 이렇게 Request/Response 형식의 메소드들을 가지는건가?
    func execute(request: SearchMoviesUseCaseRequest) async throws -> (cached: Bool, MoviesPage)
}

final class DefaultSearchMoviesUseCase: SearchMoviesUseCase {
    
    // UseCase는 Repositorty에 종속성을 가짐...
    private let moviesRepository: MoviesRepository
    private let moviesQueriesRepository: MoviesQueriesRepository
    
    init(moviesRepository: MoviesRepository, 
         moviesQueriesRepository: MoviesQueriesRepository) {
        self.moviesRepository = moviesRepository
        self.moviesQueriesRepository = moviesQueriesRepository
    }
    
    func execute(request: SearchMoviesUseCaseRequest) async throws -> (cached: Bool, MoviesPage) {
        let result = try await moviesRepository.fetchMoviesList(
            query: request.query, page: request.page)
        
        try await self.moviesQueriesRepository.saveRecentQuery(
            query: request.query)
        
        return result
    }
}

struct SearchMoviesUseCaseRequest {
    let query: MovieQuery
    let page: Int
}
