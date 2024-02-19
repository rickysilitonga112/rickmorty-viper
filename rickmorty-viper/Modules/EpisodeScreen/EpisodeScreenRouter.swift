// 
//  EpisodeScreenRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
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
        view.navigationItem.largeTitleDisplayMode = .automatic
        return view
    }
    
    func navigateToDetailEpisode(from navigation: UINavigationController,
                                 with data: Episode) {
        let nextVC = EpisodeDetailRouter().showView(with: data)
        navigation.pushViewController(nextVC, animated: true)
    }
    
    func navigateToSearch(from navigation: UINavigationController,
                          with data: SearchType) {
        let nextVC = SearchRouter().showView(with: data)
        navigation.pushViewController(nextVC, animated: true)
    }
}
