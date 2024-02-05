// 
//  CharacterDetailRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 02/02/24.
//

import UIKit

class CharacterDetailRouter {
    func showView(with data: Character) -> CharacterDetailView {
        let storyboardId = String(describing: CharacterDetailView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: storyboardId) as? CharacterDetailView else {
            fatalError("Error loading Storyboard")
        }
        let interactor = CharacterDetailInteractor()
        let presenter = CharacterDetailPresenter(interactor: interactor)
        
        view.presenter = presenter
        view.character = data
        return view
    }
    
    /*
    func pushToSecondVC(using navigation: UINavigationController, with data: AnyEntity) {
        let secondVCRouter = SeconVCRouter.showView(with: data)
        navigation.pushViewController(secondVCRouter, animated: true)
    }
     */
    
}
