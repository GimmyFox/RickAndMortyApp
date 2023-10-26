//
//  CharacterDescriptionRequest.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 26.10.2023.
//

import Foundation


struct CharacterOriginRequest: ApiRequestProtocol {
    typealias Response = OriginModel
    var parameters: [URLQueryItem]? = nil
    
    var endpoint: String
    
    
}
