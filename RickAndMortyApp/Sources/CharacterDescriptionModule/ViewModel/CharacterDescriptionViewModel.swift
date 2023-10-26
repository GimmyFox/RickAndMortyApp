//
//  CharacterDescriptioViewModel.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 22.08.2023.
//

import Foundation

class CharacterDescriptionViewModel: ObservableObject {
    let model: CharacterInfo
    @Published var isLoading = false
    @Published var origin: OriginModel?
    @Published var episodes: [EpisodeModel] = []
    
    let networkService: NetworkServiceProtocol
    
    init(model: CharacterInfo, networkService: NetworkServiceProtocol) {
        self.model = model
        self.networkService = networkService
        getCharacterOrigin()
        getCharaterEpisodes()
    }
    
    private func getCharacterOrigin() {
        
        isLoading = true
        guard let url = URL(string: model.origin.url) else {return}
        let path = url.path()
        let request = CharacterOriginRequest(endpoint: path)
        networkService.request(request: request) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.origin = data
                }
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self?.isLoading = false
            }
        }
    }
    
    private func getCharaterEpisodes() {
        isLoading = true
        for episode in model.episode {
            guard let url = URL(string: episode) else {
                return
            }
            let path = url.path()
            let request = CharacterEpisodeRequest(endpoint: path)
            networkService.request(request: request) { [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.episodes.append(data)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
}
