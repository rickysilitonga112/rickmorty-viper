//
//  ImageLoader.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 02/02/24.
//

import Foundation

class RMImageLoader {
    static let shared = RMImageLoader()
    
    public func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        // TODO: - create cache mechanism for image
        
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data,
               error == nil else {
                completion(.failure(error ?? URLError(URLError.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
    }
}
