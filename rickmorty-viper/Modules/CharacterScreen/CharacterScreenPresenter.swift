// 
//  CharacterScreenPresenter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import Foundation
import RxSwift

class CharacterScreenPresenter: BasePresenter {
    
    private let interactor: CharacterScreenInteractor
    private let router = CharacterScreenRouter()
    
    init(interactor: CharacterScreenInteractor) {
        self.interactor = interactor
    }
    
    func fetchInitialCharacter() -> Observable<CharacterEntity?> {
        return interactor.fetchInitialCharacters()
    }
    
    func fetchCharacterImages(from characters: [Character]) -> Observable<[UIImage?]> {
        return interactor.fetchCharacterImage(from: characters)
    }
    
    func fetchMoreCharacters(from url: URL?) -> Observable<CharacterEntity?> {
        return interactor.fetchMoreCharacters(from: url)
    }
}
