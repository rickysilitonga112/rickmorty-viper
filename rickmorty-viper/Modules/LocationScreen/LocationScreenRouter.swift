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
        let storyboard = UIStoryboard(name: String(describing: LocationScreenView.self), bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: String(describing: LocationScreenView.self)) as? LocationScreenView else {
            fatalError("Error loading storyboard")
        }
        view.presenter = presenter
        return view
    }
    
    func navigateToLocationDetail(from navigation: UINavigationController,
                                  with data: Location) {
     
        let nextVC = LocationDetailRouter().showView(with: data)
        nextVC.navigationItem.largeTitleDisplayMode = .never
        navigation.pushViewController(nextVC, animated: true)   
    }
    
    func navigateToSearch(from navigation: UINavigationController,
                          with data: SearchType) {
        let nextVC = SearchRouter().showView(with: data)
        navigation.pushViewController(nextVC, animated: true)
    }
}
