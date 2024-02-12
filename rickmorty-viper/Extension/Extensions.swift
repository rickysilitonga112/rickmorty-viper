//
//  Extensions.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 12/02/24.
//

import Foundation
import UIKit

extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0 / 255 ... 255 / 255)
        let green = CGFloat.random(in: 0 / 255 ... 255 / 255)
        let blue = CGFloat.random(in: 0 / 255 ... 255 / 255)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
