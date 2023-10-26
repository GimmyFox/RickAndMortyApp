//
//  CharactersRequest.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 26.10.2023.
//

import Foundation

struct CharacterRequest: ApiRequestProtocol {
    var parameters: [URLQueryItem]? = nil
    
    typealias Response = ResultModel
    
    var endpoint: String {
        "/api/character"
    }
}
