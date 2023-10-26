//
//  CharacterEpisodesService.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 26.10.2023.
//

import Foundation


protocol CharacterEpisodeProtocol {
    func requestCharacterEpisodes(request: CharacterEpisodeRequest, completion: @escaping (Result<EpisodeModel, ApiClientError>) -> Void)
}

final class CharacterEpisodeService: CharacterEpisodeProtocol {
    
    let client: NetworkServiceProtocol
    init(client: NetworkServiceProtocol) {
        self.client = client
    }
    
    
    func requestCharacterEpisodes(request: CharacterEpisodeRequest, completion: @escaping (Result<EpisodeModel, ApiClientError>) -> Void) {
        client.request(request: request) { result in
            completion(result)
        }
    }
}
