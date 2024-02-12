// 
//  SearchRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 12/02/24.
//

import UIKit

class SearchRouter {
    
    func showView() -> SearchView {
        let interactor = SearchInteractor()
        let presenter = SearchPresenter(interactor: interactor)
        let storyboard = UIStoryboard(name: String(describing: SearchView.self), bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: String(describing: SearchView.self)) as? SearchView else {
            fatalError("Error loading storyboard")
        }
        view.presenter = presenter
        return view
    }
}
