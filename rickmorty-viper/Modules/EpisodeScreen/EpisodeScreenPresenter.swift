// 
//  EpisodeScreenPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import Foundation

class EpisodeScreenPresenter {
    
    private let interactor: EpisodeScreenInteractor
    private let router = EpisodeScreenRouter()
    
    init(interactor: EpisodeScreenInteractor) {
        self.interactor = interactor
    }
    
}
