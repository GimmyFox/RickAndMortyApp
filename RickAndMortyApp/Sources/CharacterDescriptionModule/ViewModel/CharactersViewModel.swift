//
//  ViewModel.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 17.08.2023.
//

import Foundation

class CharactersViewModel {
    var mainModel: ResultModel?
    
    init() {
        getChar()
    }
    
    
    func getChar() {
        Task {
            do {
                mainModel = try await NetworkManager.shared.getCharacters()
            }
        }
    }
    
}





