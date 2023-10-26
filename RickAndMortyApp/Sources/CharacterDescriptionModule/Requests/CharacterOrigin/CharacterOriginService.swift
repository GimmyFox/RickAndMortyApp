//
//  CharacterDescriptionService.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 26.10.2023.
//

import Foundation


protocol CharacterOriginProtocol {
    func requestCharacterOrigin(request: CharacterOriginRequest, completion: @escaping (Result<OriginModel, ApiClientError>) -> Void)
}

final class CharacterOriginService: CharacterOriginProtocol {
    
    let client: NetworkServiceProtocol
    init(client: NetworkServiceProtocol) {
        self.client = client
    }
    
    
    func requestCharacterOrigin(request: CharacterOriginRequest, completion: @escaping (Result<OriginModel, ApiClientError>) -> Void) {
        client.request(request: request) { result in
            completion(result)
        }
    }
}
