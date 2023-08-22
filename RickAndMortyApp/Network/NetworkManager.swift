//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 21.08.2023.
//

import Foundation


enum NetworkError: Error {
    case invalidUrl
    case requestFailer(Error)
    case noData
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private let session = URLSession.shared
    
    func getCharacters() async throws -> ResultModel? {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            return nil
        }
        let (data, _) = try await session.data(from: url)
        let result = try JSONDecoder().decode(ResultModel.self, from: data)
        return result
    }
    
    
    func getCharacterOrigin(url: String) async throws -> OriginModel? {
        guard let url = URL(string: url) else {return nil}
        let (data, _) = try await session.data(from: url)
        let result = try JSONDecoder().decode(OriginModel.self, from: data)
        return result
    }
    
    func getCharacterEpisodes(url: String) async throws -> EpisodeModel? {
        guard let url = URL(string: url) else {return nil}
        let (data, _) = try await session.data(from: url)
        let result = try JSONDecoder().decode(EpisodeModel.self, from: data)
        return result
    }
}
