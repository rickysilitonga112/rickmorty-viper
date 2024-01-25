//
//  EpisodeScreenRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import UIKit

class EpisodeScreenRouter {
    func showView() -> EpisodeScreenView {
        let storyboardId = String(describing: EpisodeScreenView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: storyboardId) as? EpisodeScreenView else {
            fatalError("Error loading Storyboard")
        }
        let interactor = EpisodeScreenInteractor()
        let presenter = EpisodeScreenPresenter(interactor: interactor)
        view.presenter = presenter
        return view
    }
}
