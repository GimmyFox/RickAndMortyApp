//
//  DataRequest.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 26.10.2023.
//

import Foundation


protocol ApiRequestProtocol {
    associatedtype Response: Decodable
    
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [URLQueryItem]? { get }
    
    func makeRequest(host: String) -> URLRequest?
}

extension ApiRequestProtocol {
    var headers: [String: String]? {
        nil
    }
    
    var parameters: [String: String]? {
        nil
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func makeRequest(host: String) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = endpoint
        urlComponents.queryItems = parameters
        guard let url = urlComponents.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers?.forEach({ (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        })
        return request
    }
}
