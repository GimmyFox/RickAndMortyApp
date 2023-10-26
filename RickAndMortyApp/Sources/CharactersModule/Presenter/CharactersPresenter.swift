//
//  CharactersPresenter.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 26.10.2023.
//

import Foundation
import UIKit

protocol CharactersPresenterProtocol {
    func requestCharacters()
    var mainModel: ResultModel? { get }
}

class CharactersPresenter: CharactersPresenterProtocol {
    
    weak var view: CharactersViewController?
    private let networkService: NetworkServiceProtocol
    var mainModel: ResultModel?
    
    
    init(view: CharactersViewController, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func requestCharacters() {
        view?.startActivityIndicator()
        let request = CharacterRequest()
        networkService.request(request: request) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.mainModel = data
                    self?.view?.success()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.onFailure(error: error)
                }
            }
            DispatchQueue.main.async {
                self?.view?.stopActivityIndicator()
            }
        }
    }
}
