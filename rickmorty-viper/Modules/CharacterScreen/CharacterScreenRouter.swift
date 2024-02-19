// 
//  CharacterScreenRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit

class CharacterScreenRouter {
    
    func showView() -> CharacterScreenView {
        let interactor = CharacterScreenInteractor()
        let presenter = CharacterScreenPresenter(interactor: interactor)
        let view = CharacterScreenView.instance(withPresenter: presenter)
        return view
    }
    
    func navigateToDetailCharacter(from navigation: UINavigationController,
                                   with data: Character) {
        let nextVC = CharacterDetailRouter().showView(with: data)
        
        navigation.pushViewController(nextVC, animated: true)
    }
    
    func navigateToSearch(from navigation: UINavigationController, 
                          with data: SearchType) {
        let nextVC = SearchRouter().showView(with: data)
        navigation.pushViewController(nextVC, animated: true)
    }
}
