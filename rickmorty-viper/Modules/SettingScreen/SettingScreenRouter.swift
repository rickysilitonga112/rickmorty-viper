//
//  SettingScreenRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import Foundation
import UIKit

class SettingScreenRouter {
    func showView() -> SettingScreenView {
        let storyboardId = String(describing: SettingScreenView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: storyboardId) as? SettingScreenView else {
            fatalError("Error loading storyboard")
        }
        let interactor = SettingScreenInteractor()
        let presenter = SettingScreenPresenter(interactor: interactor)
        view.presenter = presenter
        return view
    }
}
