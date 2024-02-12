// 
//  SettingScreenEntity.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import Foundation
import UIKit

enum SettingSectionType: CaseIterable {
    case rateApp
    case contact
    case terms
    case privacy
    case apiReference
    case series
    case code
    
    var title: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contact:
            return "Contact Us"
        case .terms:
            return "Terms of Services"
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "Api Reference"
        case .series:
            return "View Video Series"
        case .code:
            return "View App Code"
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contact:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .series:
            return UIImage(systemName: "tv.fill")
        case .code:
            return UIImage(systemName: "hammer.fill")
        }
    }
    
    var containerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemTeal
        case .contact:
            return .systemPink
        case .terms:
            return .systemBlue
        case .privacy:
            return .systemMint
        case .apiReference:
            return .systemRed
        case .series:
            return .systemOrange
        case .code:
            return .systemYellow
        }
    }
    
    var optionUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contact:
            return URL(string: "https://rickandmortyapi.com/support-us")
        case .terms:
            return URL(string: "https://iosacademy.io/terms/")
        case .privacy:
            return URL(string: "https://iosacademy.io/privacy/")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/documentation")
        case .series:
            return URL(string: "https://www.youtube.com/playlist?list=PLZ5bOCJTjrnwR3iX0I6yXhUQax5CoXN_t")
        case .code:
            return URL(string: "https://github.com/rickysilitonga112/rickmorty-viper")
        }
    }
}
