//
//  Endpoint.swift
//  Movies
//
//  Created by wonki on 10/31/23.
//

import Foundation
import Alamofire

enum RequestGenerationError: Error {
    case components
}

class Endpoint<R> {
    let path: String
    let isFullPath: Bool
    let method: HTTPMethod
    let headerParameters: [String: String]
    let queryParametersEncodable: Encodable?
    let queryParameters: [String: Any]
    let bodyParametersEncodable: Encodable?
    let bodyParameters: [String: Any]
    // TODO: body encoder
    // TODO: response decoder
    
    init(
        path: String,
        isFullPath: Bool = false,
        method: HTTPMethod = .get,
        headerParameters: [String : String] = [:],
        queryParametersEncodable: Encodable? = nil,
        queryParameters: [String : Any] = [:],
        bodyParametersEncodable: Encodable? = nil,
        bodyParameters: [String : Any] = [:]
    ) {
        self.path = path
        self.isFullPath = isFullPath
        self.method = method
        self.headerParameters = headerParameters
        self.queryParametersEncodable = queryParametersEncodable
        self.queryParameters = queryParameters
        self.bodyParametersEncodable = bodyParametersEncodable
        self.bodyParameters = bodyParameters
    }
    
    func url(with config: NetworkConfigurable) throws -> URL {
        let baseUrl = config.baseUrl.absoluteString.last != "/"
        ? config.baseUrl.absoluteString + "/"
        : config.baseUrl.absoluteString
        let endpoint = isFullPath ? path : baseUrl.appending(path)
        
        guard var urlComponents = URLComponents(
            string: endpoint
        ) else { throw RequestGenerationError.components }
        
        var urlQueryItems = [URLQueryItem]()
        let queryParameters = try queryParametersEncodable?.toDictionary() ?? self.queryParameters
        queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(
                name: $0.key, value: "\($0.value)"
            ))
        }
        config.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(
                name: $0.key, value: $0.value
            ))
        }
        urlComponents.queryItems = urlQueryItems.isNotEmpty ? urlQueryItems : nil
        guard let url = urlComponents.url else {
            throw RequestGenerationError.components
        }
        return url
    }
    
    func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        let url = try self.url(with: config)
        var request = URLRequest(url: url)
        var allHeaders: [String: String] = config.headers
        headerParameters.forEach { key, value in
            allHeaders.updateValue(value, forKey: key)
        }
        
        let bodyParameters = try bodyParametersEncodable?.toDictionary() ?? self.bodyParameters
        
        if bodyParameters.isNotEmpty {
            if let bodyParameters = bodyParameters as? Encodable {
                request.httpBody = try JSONEncoder().encode(bodyParameters)
            }
        }
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = allHeaders
        return request
    }
}

private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String : Any]
    }
}
