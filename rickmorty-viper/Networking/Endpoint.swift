//
//  Endpoint.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import Foundation

/// Represent unique API Endpoint
@frozen enum Endpoint: String, CaseIterable, Hashable {
    /// endpoint to get character
    case character
    /// endpoint to get location
    case location
    /// endpoint to get episode
    case episode
}
