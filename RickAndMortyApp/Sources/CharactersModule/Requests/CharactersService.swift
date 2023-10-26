//
//  CharactersService.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 26.10.2023.
//

import Foundation

protocol NewsServiceProtocol {
    func requestCharacters(request: CharacterRequest, completion: @escaping (Result<ResultModel, ApiClientError>) -> Void)
}

final class NewsService: NewsServiceProtocol {
    
    let client: NetworkServiceProtocol
    init(client: NetworkServiceProtocol) {
        self.client = client
    }
    
    
    func requestCharacters(request: CharacterRequest, completion: @escaping (Result<ResultModel, ApiClientError>) -> Void) {
        client.request(request: request) { result in
            completion(result)
        }
    }
}
