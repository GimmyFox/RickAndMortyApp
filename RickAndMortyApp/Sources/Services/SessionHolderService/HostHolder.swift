//
//  HostHolder.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 26.10.2023.
//

import Foundation


protocol HostHolderService {
    var host: String { get }
}

final class HostHolder: HostHolderService {
    static let shared = HostHolder()
    
    private init() {}
    
    var host: String {
        "rickandmortyapi.com"
    }
}
