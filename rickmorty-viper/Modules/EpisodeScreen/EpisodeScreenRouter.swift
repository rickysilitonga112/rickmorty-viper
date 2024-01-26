// 
//  EpisodeScreenRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit

class EpisodeScreenRouter {
    func showView() -> EpisodeScreenView {
        let interactor = EpisodeScreenInteractor()
        let presenter = EpisodeScreenPresenter(interactor: interactor)
        let view = EpisodeScreenView.instance(withPresenter: presenter)
        return view
    }
    
    /*
    func pushToSecondVC(using navigation: UINavigationController, with data: AnyEntity) {
        let secondVCRouter = SeconVCRouter.showView(with: data)
        navigation.pushViewController(secondVCRouter, animated: true)
    }
     */
    
}
