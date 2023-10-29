//
//  UseCase.swift
//  Movies
//
//  Created by wonki on 10/26/23.
//

import Foundation
import Combine

protocol UseCase {
    @discardableResult
    func start() -> Cancellable?
}
