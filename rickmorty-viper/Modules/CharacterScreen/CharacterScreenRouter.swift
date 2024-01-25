//
//  CharacterRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import UIKit

class CharacterScreenRouter {
    func showView() -> CharacterScreenView {
        let storyboardId = String(describing: CharacterScreenView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: storyboardId) as? CharacterScreenView else {
            fatalError("Error loading Storyboard")
        }
        let interactor = CharacterScreenInteractor()
        let presenter = CharacterScreenPresenter(interactor: interactor)
        view.presenter = presenter
        return view
    }
}
