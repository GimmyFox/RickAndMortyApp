//
//  Builder.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 26.10.2023.
//

import Foundation
import UIKit
import SwiftUI

protocol BuilderProtocol {
    func createMainViewController() -> UIViewController
    func createDescriptionViewController(model: CharacterInfo, action: @escaping ()->()) -> UIViewController
}

class Builder: BuilderProtocol {
    
    
    func createMainViewController() -> UIViewController {
        let vc = CharactersViewController()
        let network = DefaultNetworkService()
        let presenter = CharactersPresenter(view: vc, networkService: network)
        vc.presenter = presenter
        return vc
    }
    
    func createDescriptionViewController(model: CharacterInfo, action: @escaping ()->()) -> UIViewController {
        let network = DefaultNetworkService()
        let vm = CharacterDescriptionViewModel(model: model, networkService: network)
        let vc = UIHostingController(rootView: CharacterDescriptionView(vm: vm, action: action))
        return vc
    }
    
}
