//
//  NetworkService.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 26.10.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<Request: ApiRequestProtocol>(request: Request, completion: @escaping (Result<Request.Response, ApiClientError>) -> Void)
}

struct DefaultNetworkService: NetworkServiceProtocol {
    
    let host: String
    
    init(host: String = HostHolder.shared.host) {
        self.host = host
    }
    
    func request<Request: ApiRequestProtocol>(request: Request, completion: @escaping (Result<Request.Response, ApiClientError>) -> Void) {
        
        guard var request = request.makeRequest(host: host) else {
            return completion(.failure(ApiClientError.request))
        }
        
        
        let task = URLSession.shared.dataTask(with: request) {  (data, response, error) in
            guard error == nil, let httpResponse = response as? HTTPURLResponse else {
                
                return completion(.failure(ApiClientError.network))
            }
            guard let data = data else {
                return completion(.failure(ApiClientError.empty))
            }
            
            guard httpResponse.statusCode == 200 else {
                return completion(.failure(ApiClientError.service(httpResponse.statusCode)))
            }
            let decoder = JSONDecoder()
            guard let result = try? decoder.decode(Request.Response.self, from: data) else {
                return completion(.failure(ApiClientError.deserialize))
            }
            completion(.success(result))
        }
        task.resume()
    }
}
