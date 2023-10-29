//
//  MoviesSearchFlowCoordinator.swift
//  Movies
//
//  Created by wonki on 10/26/23.
//

import Foundation
import UIKit

protocol MoviesSearchFlowCoordinatorDependencies {
    func makeMoviesListViewController() -> MoviesListViewController
}

final class MoviesSearchFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: MoviesSearchFlowCoordinatorDependencies
    
    private weak var moviesListVC: MoviesListViewController?
    private weak var moviesQueriesSuggestionVC: UIViewController?
    
    init(navigationController: UINavigationController, dependencies: MoviesSearchFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let vc = dependencies.makeMoviesListViewController()
        navigationController?.pushViewController(vc, animated: false)
        moviesListVC = vc
    }
}
