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
    init(model: CharacterInfo) {
        self.model = model
        if model.origin.url.isEmpty {
            print("emprt")
        }
        print(model.origin.url)
        getCharacterOrigin()
    }
    
    func getCharacterOrigin() {
        isLoading = true
        Task {
            do {
                defer {
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
                guard !model.origin.url.isEmpty else {
                    return
                }
                let result = try await NetworkManager.shared.getCharacterOrigin(url: model.origin.url)
                DispatchQueue.main.async {
                    self.origin = result
                }
            }
            
            
        }
    }
}
