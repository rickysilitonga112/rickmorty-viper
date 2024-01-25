//
//  EpisodeScreenRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import UIKit

class EpisodeScreenRouter {
    func showView() -> EpisodeScreenViewController {
        let view = EpisodeScreenViewController()
        let interactor = EpisodeScreenInteractor()
        let presenter = EpisodeScreenPresenter(interactor: interactor)
        view.presenter = presenter
        return view
    }
}
