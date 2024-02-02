//
//  ApiManager.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import Foundation

/// Primary api service object to get rick and morty data
class ApiManager {
    /// shared singleton instance
    static let shared = ApiManager()
    
    // TODO: create api cache manager
    private let cacheManager = APICacheManager()
    
    private init() {}
    
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
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
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) {[weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
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
