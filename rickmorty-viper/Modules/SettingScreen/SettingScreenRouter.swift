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
        let view = SettingScreenView.instance(withPresenter: presenter)
        return view
    }
    /*
    func pushToSecondVC(using navigation: UINavigationController, with data: AnyEntity) {
        let secondVCRouter = SeconVCRouter.showView(with: data)
        navigation.pushViewController(secondVCRouter, animated: true)
    }
     */
    
}
