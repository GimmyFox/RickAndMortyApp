//
//  CharacterEpisodesRequest.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 26.10.2023.
//

import Foundation


struct CharacterEpisodeRequest: ApiRequestProtocol {
    typealias Response = EpisodeModel
    var parameters: [URLQueryItem]? = nil
    var endpoint: String
}
