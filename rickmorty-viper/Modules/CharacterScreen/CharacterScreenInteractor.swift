// 
//  CharacterScreenInteractor.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import Foundation
import RxSwift

class CharacterScreenInteractor: BaseInteractor {
    
    func fetchInitialCharacters() -> PublishSubject<CharacterEntity?> {
        let subject = PublishSubject<CharacterEntity?>()
        api.requestAPI(.listCharactersRequests)
            .subscribe { (data: CharacterEntity) in
                subject.onNext(data)
            } onError: { error in
                subject.onError(error)
            }
            .disposed(by: bag)
        return subject
    }
    
    func fetchMoreCharacters(from url: URL?) -> PublishSubject<CharacterEntity?> {
        let subject = PublishSubject<CharacterEntity?>()
        guard let url = url else {
            subject.onError(ServiceError.invalidUrl)
            return subject
        }
        guard let request = Request(url: url) else {
            subject.onError(ServiceError.failedToCreateRequest)
            return subject
        }
        api.requestAPI(request)
            .subscribe { (data: CharacterEntity) in
                subject.onNext(data)
            } onError: { error in
                subject.onError(error)
            }.disposed(by: bag)
        return subject
    }
}
