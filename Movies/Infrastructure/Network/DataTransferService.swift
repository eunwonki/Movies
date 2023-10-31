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

protocol DataTransferService {
    @discardableResult
    func request<T: Decodable>(
        with endpoint: Endpoint<T>
    ) async throws -> T
    
    func request() async throws
}

final class DefaultDataTransferService {
    private let networkService: NetworkService
    
    init(with networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension DefaultDataTransferService: DataTransferService {
    func request<T>(with endpoint: Endpoint<T>) async throws -> T where T : Decodable {
        return try await networkService.request(endpoint: endpoint)
    }
    
    func request() async throws {}
    
}
