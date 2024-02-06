//
//  EpisodeScreenEntity.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import Foundation

struct EpisodeEntity: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [Episode]
}

struct Episode: Codable {
    let id: Int
    let name: String
    let air_date:  String
    let episode:  String
    let characters: [String]
    let url:  String
    let created: String
}
