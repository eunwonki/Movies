//
//  MoviesSceneDIContainer.swift
//  Movies
//
//  Created by wonki on 10/26/23.
//

import Foundation
import UIKit

final class MoviesSceneDIContainer: MoviesSearchFlowCoordinatorDependencies {
    
    func makeMoviesListViewController() -> MoviesListViewController {
        MoviesListViewController.create(
            with: makeMoviesListViewModel()
        )
    }
    
    func makeMoviesListViewModel() -> MoviesListViewModel {
        DefaultMoviesListViewModel()
    }
    
    func makeMoviesSearchFlowCoordinator(navigationCotroller: UINavigationController) -> MoviesSearchFlowCoordinator {
        MoviesSearchFlowCoordinator(
            navigationController: navigationCotroller,
            dependencies: self
        )
    }
}
