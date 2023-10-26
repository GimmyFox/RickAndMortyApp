//
//  RnMModel.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 21.08.2023.
//

import Foundation


struct ResultModel: Decodable {
    let info: Info
    let results: [CharacterInfo]
}

struct Info: Decodable {
    let count, pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct CharacterInfo: Decodable {
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let type: String
    let gender: Gender
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum Gender: String, Decodable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct Location: Decodable {
    let name: String
    let url: String
}

enum Species: String, Decodable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
