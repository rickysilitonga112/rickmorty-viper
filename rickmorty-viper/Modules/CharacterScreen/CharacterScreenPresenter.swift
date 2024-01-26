// 
//  CharacterScreenPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import Foundation

class CharacterScreenPresenter {
    
    private let interactor: CharacterScreenInteractor
    private let router = CharacterScreenRouter()
    
    init(interactor: CharacterScreenInteractor) {
        self.interactor = interactor
    }
    
}
