//
//  MoviesSceneDIContainer.swift
//  Movies
//
//  Created by wonki on 10/26/23.
//

import Foundation
import UIKit

final class MoviesSceneDIContainer: MoviesSearchFlowCoordinatorDependencies {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    // MARK: - Persistent Storage
    
    lazy var moviesResponseCache: MoviesResponseStorage = CoreDataMoviesResponseStorage()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func makeMoviesListViewController() -> MoviesListViewController {
        MoviesListViewController.create(
            with: makeMoviesListViewModel()
        )
    }
    
    // MARK: - Use Cases
    
    func makeSearchMoviesUseCase() -> SearchMoviesUseCase {
        DefaultSearchMoviesUseCase(
            moviesRepository: makeMoviesRepository(),
            moviesQueriesRepository: makeMoviesQueriesRepository()
        )
    }
    
    // MARK: - Repositories
    
    func makeMoviesRepository() -> MoviesRepository {
        DefaultMoviesRepository(
            dataTransferService: dependencies.apiDataTransferService,
            cache: moviesResponseCache)
    }
    
    func makeMoviesQueriesRepository() -> MoviesQueriesRepository {
        DefaultMoviesQueriesRepository()
    }
    
    
    // MARK: - Movies List
    
    func makeMoviesListViewModel() -> MoviesListViewModel {
        DefaultMoviesListViewModel(
            searchMoviesUseCase: makeSearchMoviesUseCase())
    }
    
    func makeMoviesSearchFlowCoordinator(navigationCotroller: UINavigationController) -> MoviesSearchFlowCoordinator {
        MoviesSearchFlowCoordinator(
            navigationController: navigationCotroller,
            dependencies: self
        )
    }
    
    // MARK: - Movie Details
}
