//
//  SettingScreenPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import UIKit

class SettingScreenPresenter {
    private let interactor: SettingScreenInteractor
    private let router = SettingScreenRouter()
    
    init(interactor: SettingScreenInteractor) {
        self.interactor = interactor
    }
}
