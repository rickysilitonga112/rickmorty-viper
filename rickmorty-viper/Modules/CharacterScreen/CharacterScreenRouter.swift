//
//  CharacterRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import UIKit

class CharacterScreenRouter {
    func showView() -> CharacterScreenViewController {
        let view = CharacterScreenViewController()
        let interactor = CharacterScreenInteractor()
        let presenter = CharacterScreenPresenter(interactor: interactor)
        view.presenter = presenter
        return view
    }
}
