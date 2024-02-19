//
//  SearchConstants.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 16/02/24.
//

import Foundation

enum SearchType {
    case character
    case location
    case episode
    
    var endpoint: Endpoint {
        switch self {
        case .character:
            return .character
        case .location:
            return .location
        case .episode:
            return .episode
        }
    }
    
    var title: String {
        switch self {
        case .character:
            return "Search character..."
        case.location:
            return "Search location..."
        case .episode:
            return "Search episode..."
        }
    }
}


enum DynamicOption: String {
    case status = "Status"
    case gender = "Gender"
    case locationType = "Location Type"
    
    var queryArgument: String {
        switch self {
        case .status:
            return "status"
        case .gender:
            return "gender"
        case .locationType:
            return "type"
        }
    }
    
    var choices: [String] {
        switch self {
        case .status:
            return ["alive", "dead", "unknown"]
        case .gender:
            return ["female", "male", "genderless", "unknown"]
        case .locationType:
            return ["planet", "cluster", "microverse"]
        }
    }
}

enum Segues {
    static let toSearchResultView = "toSearchResultsView"
}
