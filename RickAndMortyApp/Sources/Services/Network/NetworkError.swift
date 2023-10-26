//
//  NetworkError.swift
//  RickAndMortyApp
//
//  Created by Maksim Guzeev on 26.10.2023.
//

import Foundation


enum ApiClientError: Error {
    case request
    case network
    case empty
    case service(_ code: Int)
    case deserialize
}

