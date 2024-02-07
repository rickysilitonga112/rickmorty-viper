// 
//  EpisodeDetailEntity.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 07/02/24.
//

import Foundation

enum EpisodeDetailSection {
    case info(infoCells: [SingleCellEntity])
    case characters(characters: [Character])
}

struct SingleCellEntity {
    let title: String
    let value: String
}
