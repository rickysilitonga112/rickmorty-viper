//
//  CharacterPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import UIKit

class CharacterScreenPresenter {
    private var interactor: CharacterScreenInteractor
    private var router = CharacterScreenRouter()
    
    init(interactor: CharacterScreenInteractor) {
        self.interactor = interactor
    }
}
