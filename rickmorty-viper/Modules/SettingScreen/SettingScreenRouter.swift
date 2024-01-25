//
//  SettingScreenRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import Foundation
import UIKit

class SettingScreenRouter {
    func showView() -> SettingScreenViewController {
        let view = SettingScreenViewController()
        let interactor = SettingScreenInteractor()
        let presenter = SettingScreenPresenter(interactor: interactor)
        view.presenter = presenter
        return view
    }
}
