//
//  LocationScreenPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import UIKit

class LocationScreenPresenter {
    private let interactor: LocationScreenInteractor
    private let router = LocationScreenRouter()
    
    init(interactor: LocationScreenInteractor) {
        self.interactor = interactor
    }
}
