// 
//  SearchOptionPickerPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 16/02/24.
//

import Foundation

class SearchOptionPickerPresenter: BasePresenter {
    
    private let interactor: SearchOptionPickerInteractor
    private let router = SearchOptionPickerRouter()
    
    init(interactor: SearchOptionPickerInteractor) {
        self.interactor = interactor
    }
    
}
