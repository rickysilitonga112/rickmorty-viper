//
//  CharacterDetailEntity.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 02/02/24.
//

import Foundation
import UIKit

enum CharacterDetailSection {
    case photo(url: URL)
    case info(data: [CharacterInfoEntity])
    case episodes(urlStrings: [String])
}

struct CharacterInfoEntity: Codable {
    let type: CharacterInfoSection
    let value: String
    
    var displayValue: String {
        if value.isEmpty {
            return "None"
        }
        
        if let date = Self.dateFormatter.date(from: value),
           type == .created {
            return Self.shortDateFormatter.string(from: date)
        }
        
        return value
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        formatter.timeZone = .current
        return formatter
    }()

    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.timeZone = .current
        return formatter
    }()
}

enum CharacterInfoSection: String, Codable {
    case status
    case gender
    case type
    case species
    case origin
    case created
    case location
    case episodeCount
    
    var displayTitle: String {
        switch self {
        case .status,
                .gender,
                .type,
                .species,
                .origin,
                .created,
                .location:
            return rawValue.uppercased()
        case .episodeCount:
            return "TOTAL EPISODE"
        }
    }
    
    var iconName: String {
        switch self {
        case .status:
            return "bell"
        case .gender:
            return "bell"
        case .type:
            return "bell"
        case .species:
            return "bell"
        case .origin:
            return "bell"
        case .created:
            return "bell"
        case .location:
            return "bell"
        case .episodeCount:
            return "bell"
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .status:
            return .systemBlue
        case .gender:
            return .systemRed
        case .type:
            return .systemPurple
        case .species:
            return .systemGreen
        case .origin:
            return .systemOrange
        case .created:
            return .systemPink
        case .location:
            return .systemYellow
        case .episodeCount:
            return .systemMint
        }
    }
}
