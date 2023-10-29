//
//  AppFlowCoordinator.swift
//  Movies
//
//  Created by wonki on 10/26/23.
//

import Foundation
import UIKit

final class AppFlowCoordinator {
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        let flow = moviesSceneDIContainer.makeMoviesSearchFlowCoordinator(
            navigationCotroller: navigationController)
        flow.start()
    }
}
