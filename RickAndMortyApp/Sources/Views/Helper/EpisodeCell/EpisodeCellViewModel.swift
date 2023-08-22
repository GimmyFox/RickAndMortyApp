//
//  EpisodeCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 22.08.2023.
//

import Foundation


class EpisodeCellViewModel: ObservableObject {
    @Published var model: EpisodeModel?
    let url: String
    
    init(url: String) {
        self.url = url
        getEpisode()
    }
    
    func getEpisode() {
        Task {
            do {
                let result = try await NetworkManager.shared.getCharacterEpisodes(url: url)
                DispatchQueue.main.async {
                    self.model = result
                }
            }
        }
    }
}
