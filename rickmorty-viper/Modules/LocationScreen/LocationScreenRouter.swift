//
//  LocationScreenRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import UIKit

class LocationScreenRouter {
    func showView() -> LocationScreenViewController {
        let view = LocationScreenViewController()
        let interactor = LocationScreenInteractor()
        let presenter = LocationScreenPresenter(interactor: interactor)
        view.presenter = presenter
        return view
    }
}
