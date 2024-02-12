// 
//  LocationDetailRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 11/02/24.
//

import UIKit

class LocationDetailRouter {
    
    func showView(with data: Any?) -> LocationDetailView {
        let interactor = LocationDetailInteractor()
        let presenter = LocationDetailPresenter(interactor: interactor)
        let storyboard = UIStoryboard(name: String(describing: LocationDetailView.self), bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: String(describing: LocationDetailView.self)) as? LocationDetailView else {
            fatalError("Error loading storyboard")
        }
        view.presenter = presenter
        view.location = (data as? Location)
        return view
    }
    
    func navigateToDetailCharacter(from navigation: UINavigationController,
                                   with data: Character) {
        let characterDetailView = CharacterDetailRouter().showView(with: data)
        navigation.pushViewController(characterDetailView, animated: true)
    }
}
