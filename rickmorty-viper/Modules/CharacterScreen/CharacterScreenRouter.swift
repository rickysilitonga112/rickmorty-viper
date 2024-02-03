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
}
