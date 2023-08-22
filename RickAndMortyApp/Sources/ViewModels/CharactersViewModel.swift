//
//  ViewModel.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 17.08.2023.
//

import Foundation

protocol CharactersViewModelDelegate {
    func handleActivityIndicator(isLoading: Bool)
    func completeFetching()
}


class CharactersViewModel {
    var mainModel: ResultModel?
    var delegate: CharactersViewModelDelegate?
    init() {
        self.getChar()
    }
    
    
    func getChar() {
        delegate?.handleActivityIndicator(isLoading: true)
        Task {
            do {
                mainModel = try await NetworkManager.shared.getCharacters()
            }
            DispatchQueue.main.async {
                self.delegate?.handleActivityIndicator(isLoading: false)
            }
        }
    }
    
}





