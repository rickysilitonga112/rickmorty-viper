// 
//  EpisodeDetailRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 07/02/24.
//

import UIKit

class EpisodeDetailRouter {
    
    func showView(with data: Any?) -> EpisodeDetailView {
        let interactor = EpisodeDetailInteractor()
        let presenter = EpisodeDetailPresenter(interactor: interactor)
        let view = EpisodeDetailView.instance(withPresenter: presenter)
        view.episode = (data as? Episode)
        return view
    }
    
    func navigateToDetailCharacter(from navigation: UINavigationController,
                                   with data: Character) {
        let characterDetailView = CharacterDetailRouter().showView(with: data)
        
        navigation.pushViewController(characterDetailView, animated: true)
    }
    
    /*
    func pushToSecondVC(using navigation: UINavigationController, with data: AnyEntity) {
        let secondVCRouter = SeconVCRouter.showView(with: data)
        navigation.pushViewController(secondVCRouter, animated: true)
    }
     */
    
}
