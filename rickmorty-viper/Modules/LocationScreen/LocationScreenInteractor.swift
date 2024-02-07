// 
//  LocationScreenInteractor.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import Foundation
import RxSwift

class LocationScreenInteractor: BaseInteractor {
    func fetchInitialLocations() -> PublishSubject<LocationEntity?> {
        let subject = PublishSubject<LocationEntity?>()
        api.requestAPI(.listCharactersRequests)
            .subscribe { (data: LocationEntity) in
                subject.onNext(data)
            } onError: { error in
                subject.onError(error)
            }.disposed(by: bag)
        return subject
    }
    
    func fetchMoreLocations(from url: URL?) -> PublishSubject<LocationEntity?> {
        let subject = PublishSubject<LocationEntity?>()
        
        guard let url = url else {
            subject.onError(ServiceError.invalidUrl)
            return subject
        }
        
        guard let request = Request(url: url) else {
            subject.onError(ServiceError.failedToCreateRequest)
            return subject
        }
        api.requestAPI(request)
            .subscribe { (data: LocationEntity) in
                subject.onNext(data)
            } onError: { error in
                subject.onError(error)
            }
            .disposed(by: bag)
        return subject
    }
}
