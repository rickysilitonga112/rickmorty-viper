//
//  ApiManager.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

/// Primary api service object to get rick and morty data
class ApiManager {
    /// shared singleton instance
    static let shared = ApiManager()
    
    // TODO: create api cache manager
    private let cacheManager = RMAPICacheManager()
    
    private init() {}
    
    public func fetchImage(from url: URL?) -> Observable<UIImage?> {
        return Observable.create { observer in
            guard let url = url else {
                observer.onError(ServiceError.invalidUrl)
                return Disposables.create()
            }
            
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                if let data = data, let image = UIImage(data: data) {
                    observer.onNext(image)
                } else {
                    observer.onNext(nil)
                }
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    public func requestAPI<T: Codable>(_ request: Request) -> Observable<T> {
        guard let url = self.request(from: request) else {
            return Observable.error(ServiceError.invalidUrl)
        }
        
        return Observable.create { observer in
            let session = Session.default
            
            return session.request(url)
                .rx
                .responseData()
                .observe(on: MainScheduler.instance)
                .map { $0.1 }
                .decode(type: T.self, decoder: JSONDecoder())
                .subscribe { data in
                    observer.onNext(data)
                    observer.onCompleted()
                } onError: { error in
                    print(error.localizedDescription)
                    observer.onError(error)
                }
        }
    }
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request Instance
    ///   - type: The type of object that we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(_ request: Request, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        if let cachedData = cacheManager.cacheResponse(for: request.endpoint, url: request.url) {
            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                print("Using data from cache..")
                completion(.success(result))
                
            } catch {
                completion(.failure(error))
            }
            return
        }
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(ServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }
            
            // Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(for: request.endpoint, url: request.url, data: data)
                
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    // MARK: - PRIVATE
    
    private func request(from request: Request) -> URLRequest? {
        guard let url = request.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = request.httpMethod
        return request
    }
}
