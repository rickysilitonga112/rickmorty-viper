// 
//  LocationScreenRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit

class LocationScreenRouter {
    
    func showView() -> LocationScreenView {
        let interactor = LocationScreenInteractor()
        let presenter = LocationScreenPresenter(interactor: interactor)
        let view = LocationScreenView.instance(withPresenter: presenter)
        return view
    }
    
    /*
    func pushToSecondVC(using navigation: UINavigationController, with data: AnyEntity) {
        let secondVCRouter = SeconVCRouter.showView(with: data)
        navigation.pushViewController(secondVCRouter, animated: true)
    }
     */
    
}
