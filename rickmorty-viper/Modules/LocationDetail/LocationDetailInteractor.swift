// 
//  LocationDetailInteractor.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 11/02/24.
//

import Foundation
import RxSwift

class LocationDetailInteractor: BaseInteractor {
    
    func fetchCharacter(with url: URL?) -> PublishSubject<Character?> {
        let subject = PublishSubject<Character?>()
        
        guard let url = url else {
            subject.onError(ServiceError.invalidUrl)
            return subject
        }
        guard let request = Request(url: url) else {
            subject.onError(ServiceError.failedToCreateRequest)
            return subject
        }
        // request api
        api.requestAPI(request).subscribe { entity in
            subject.onNext(entity)
        } onError: { error in
            subject.onError(error)
        }.disposed(by: bag)
        return subject
    }
}
