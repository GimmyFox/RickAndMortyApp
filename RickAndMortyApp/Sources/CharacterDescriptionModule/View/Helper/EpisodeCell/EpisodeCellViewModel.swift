//
//  EpisodeCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 22.08.2023.
//

import Foundation


class EpisodeCellViewModel: ObservableObject {
    @Published var model: EpisodeModel
    
    
    init(model: EpisodeModel) {
        self.model = model
    }
    
}
