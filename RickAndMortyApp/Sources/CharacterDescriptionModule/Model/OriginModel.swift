//
//  LocationModel.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 22.08.2023.
//

import Foundation

// MARK: - Result
struct OriginModel: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    //let residents: [String]
    let url: String
    let created: String
}

