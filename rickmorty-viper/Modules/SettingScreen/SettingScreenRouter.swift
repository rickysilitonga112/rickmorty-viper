// 
//  SettingScreenRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit

class SettingScreenRouter {
    
    func showView() -> SettingScreenView {
        let interactor = SettingScreenInteractor()
        let presenter = SettingScreenPresenter(interactor: interactor)
        let storyboard = UIStoryboard(name: String(describing: SettingScreenView.self), bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: String(describing: SettingScreenView.self)) as? SettingScreenView else {
            fatalError("Error loading storyboard")
        }
        view.presenter = presenter
        return view
    }
}
