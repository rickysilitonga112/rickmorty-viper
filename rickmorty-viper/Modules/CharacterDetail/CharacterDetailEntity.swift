// 
//  CharacterDetailEntity.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 02/02/24.
//

import Foundation

struct CharacterDetailEntity {
    
    
    
    
    enum CharacterDetailSection {
        case photo(image: String)
        case info(data: [CharacterInfoSection])
        case episodes(urls: [URL])
    }
    
    enum CharacterInfoSection {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
    }
}
