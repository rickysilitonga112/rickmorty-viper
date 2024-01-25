//
//  LocationScreenRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import UIKit

class LocationScreenRouter {
    func showView() -> LocationScreenView {
        let storyboardId = String(describing: LocationScreenView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: storyboardId) as? LocationScreenView else {
            fatalError("Error loading storyboard.")
        }
        let interactor = LocationScreenInteractor()
        let presenter = LocationScreenPresenter(interactor: interactor)
        view.presenter = presenter
        return view
    }
}
