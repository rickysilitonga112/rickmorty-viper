// 
//  EpisodeDetailInteractor.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 07/02/24.
//

import Foundation
import RxSwift

class EpisodeDetailInteractor: BaseInteractor {
    
    func fetchCharacter(from url: URL?) -> PublishSubject<Character?> {
        let subject = PublishSubject<Character?>()
        
        guard let url = url,
              let request = Request(url: url) else {
            subject.onError(ServiceError.failedToCreateRequest)
            return subject
        }
        
        api.requestAPI(request)
            .subscribe { character in
                subject.onNext(character)
            } onError: { error in
                subject.onError(error)
            }.disposed(by: bag)
        return subject
    }
}
