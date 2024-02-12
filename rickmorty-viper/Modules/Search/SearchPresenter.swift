// 
//  SearchPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 12/02/24.
//

import Foundation
import RxSwift

class SearchPresenter: BasePresenter {
    
    private let interactor: SearchInteractor
    private let router = SearchRouter()
    
    init(interactor: SearchInteractor) {
        self.interactor = interactor
    }
    
}
