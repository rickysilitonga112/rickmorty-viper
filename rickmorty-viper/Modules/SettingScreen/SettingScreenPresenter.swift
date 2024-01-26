// 
//  SettingScreenPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import Foundation

class SettingScreenPresenter {
    
    private let interactor: SettingScreenInteractor
    private let router = SettingScreenRouter()
    
    init(interactor: SettingScreenInteractor) {
        self.interactor = interactor
    }
    
}
