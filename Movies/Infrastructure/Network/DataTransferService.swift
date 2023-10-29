//
//  DataTransferService.swift
//  Movies
//
//  Created by wonki on 10/26/23.
//

import Foundation

enum DataTransferError: Error {
    case noResponse
    case parsign(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

actor DataTransferActor {}
