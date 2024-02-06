// 
//  CharacterDetailPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 02/02/24.
//

import Foundation
import RxSwift

class CharacterDetailPresenter {
    
    private let interactor: CharacterDetailInteractor
    private let router = CharacterDetailRouter()
    
    init(interactor: CharacterDetailInteractor) {
        self.interactor = interactor
    }
    
    func fetchEpisode(from url: URL) -> Observable<Episode?> {
        return interactor.fetchEpisode(from: url)
    }
    
}
