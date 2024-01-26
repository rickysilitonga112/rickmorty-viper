// 
//  LocationScreenPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import Foundation

class LocationScreenPresenter {
    
    private let interactor: LocationScreenInteractor
    private let router = LocationScreenRouter()
    
    init(interactor: LocationScreenInteractor) {
        self.interactor = interactor
    }
    
}
