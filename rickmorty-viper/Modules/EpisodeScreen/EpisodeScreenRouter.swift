// 
//  EpisodeScreenRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit



//static func instance(withPresenter presenter: EpisodeScreenPresenter) -> EpisodeScreenView {
//    let storyboardId = String(String(describing: EpisodeScreenView.self))
//    let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
//    guard let anyView = storyboard.instantiateViewController(withIdentifier: storyboardId) as? EpisodeScreenView else {
//        fatalError("Error loading Storyboard")
//    }
//    anyView.presenter = presenter
//    return anyView
//}
class EpisodeScreenRouter {
    func showView() -> EpisodeScreenView {
        let storyboardId = String(describing: EpisodeScreenView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: storyboardId) as? EpisodeScreenView else {
            fatalError("Error loading Storyboard")
        }
        let interactor = EpisodeScreenInteractor()
        let presenter = EpisodeScreenPresenter(interactor: interactor)
        view.presenter = presenter
        view.navigationItem.largeTitleDisplayMode = .automatic
        return view
    }
    
    /*
    func pushToSecondVC(using navigation: UINavigationController, with data: AnyEntity) {
        let secondVCRouter = SeconVCRouter.showView(with: data)
        navigation.pushViewController(secondVCRouter, animated: true)
    }
     */
    
}
