//
//  NetworkService.swift
//  Movies
//
//  Created by wonki on 10/26/23.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case error(statusCode: Int, data: Data?)
    case notConnected
    case cancelled
    case generic(Error)
    case urlGeneration
}

protocol NetworkCancellable {
    func cancel()
}

extension URLSessionTask: NetworkCancellable {}

protocol NetworkService {
    func request<T:Decodable>(endpoint: Endpoint<T>) async throws -> T
}

final class DefaultNetworkService {
    
    private let config: NetworkConfigurable
    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return Session(configuration: configuration)
    }()
    
    init(config: NetworkConfigurable) {
        self.config = config
    }
    
    private func request<T:Decodable>(
        urlRequest: URLRequest
    ) async throws -> T {
        return try await session.request(urlRequest)
            .serializingDecodable()
            .value
    }
}

extension DefaultNetworkService: NetworkService {    
    func request<T>(endpoint: Endpoint<T>) async throws -> T where T : Decodable {
        let urlRequest = try endpoint.urlRequest(with: config)
        return try await request(urlRequest: urlRequest)
    }
}
