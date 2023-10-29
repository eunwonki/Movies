//
//  AppDIContainer.swift
//  Movies
//
//  Created by wonki on 10/26/23.
//

import Foundation

final class AppDIContainer {
    lazy var appConfiguration = AppConfiguration()
    
    func makeMoviesSceneDIContainer() -> MoviesSceneDIContainer {
        MoviesSceneDIContainer()
    }
}
