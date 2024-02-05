//
//  ImageLoader.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 02/02/24.
//

import Foundation
import UIKit

//class RMImageLoader {
//    static let shared = RMImageLoader()
//    private var imageDataCache = NSCache<NSString, NSData>()
//    
//    private init() {}
//    
//    public func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
//        let key = url.absoluteString as NSString
//        if let data = imageDataCache.object(forKey: key) {
//            print("DEBUG: Using image from cache..")
//            completion(.success(data as Data))
//            return
//        }
//        
//        let request = URLRequest(url: url)
//        
//        let task = URLSession.shared.dataTask(with: request) { data, _, error in
//            guard let data = data, error == nil else {
//                completion(.failure(error ?? URLError(.badServerResponse)))
//                return
//            }
//            completion(.success(data))
//            
//            let value = data as NSData
//            self.imageDataCache.setObject(value, forKey: key)
//        }
//        
//        task.resume()
//    }
//}
