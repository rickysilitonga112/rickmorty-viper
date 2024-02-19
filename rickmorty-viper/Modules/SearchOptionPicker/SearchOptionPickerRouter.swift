// 
//  SearchOptionPickerRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 16/02/24.
//

import UIKit

class SearchOptionPickerRouter {
    
    func showView(with data: DynamicOption, delegation: SearchViewDelegation?) -> SearchOptionPickerView {
        let storyboard = UIStoryboard(name: String(describing: SearchOptionPickerView.self), bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: String(describing: SearchOptionPickerView.self)) as? SearchOptionPickerView else {
            fatalError("Error loading storyboard")
        }
        let interactor = SearchOptionPickerInteractor()
        let presenter = SearchOptionPickerPresenter(interactor: interactor)
        
        view.presenter = presenter
        view.option = data
        view.delegation = delegation
        return view
    }
    
}
