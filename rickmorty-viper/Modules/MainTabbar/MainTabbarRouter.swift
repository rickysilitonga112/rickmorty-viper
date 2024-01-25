//
//  MainTabbarRouter.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 25/01/24.
//

import UIKit

class MainTabbarRouter {
    func showView() -> MainTabbarView {
        let storyBoardId = String(describing: MainTabbarView.self)
        let storyBoard = UIStoryboard(name: storyBoardId, bundle: nil)
        guard let view = storyBoard.instantiateViewController(withIdentifier: storyBoardId) as? MainTabbarView else {
            fatalError("Error loading storyboard")
        }
        let interactor = MainTabbarInteractor()
        let presenter = MainTabbarPresenter(interactor: interactor)
        view.presenter = presenter
        return view
    }
    
    func navigateToCharacter() -> UINavigationController {
        let view = UINavigationController(rootViewController: CharacterScreenRouter().showView())
        view.tabBarItem = UITabBarItem(title: "Character",
                                                image: UIImage(systemName: "person"),
                                                tag: 0
        )
        view.navigationBar.prefersLargeTitles = true
        view.navigationItem.largeTitleDisplayMode = .automatic
        return view
    }
    
    func navigateToEpisode() -> UINavigationController {
        let view = UINavigationController(rootViewController: EpisodeScreenRouter().showView())
        view.tabBarItem = UITabBarItem(title: "Episode",
                                                image: UIImage(systemName: "tv"),
                                                tag: 1
        )
        view.navigationBar.prefersLargeTitles = true
        view.navigationItem.largeTitleDisplayMode = .automatic
        return view
    }
    
    func navigateToLocation() -> UINavigationController {
        let view = UINavigationController(rootViewController: LocationScreenRouter().showView())
        view.tabBarItem = UITabBarItem(title: "Location",
                                                image: UIImage(systemName: "globe"),
                                                tag: 2
        )
        view.navigationBar.prefersLargeTitles = true
        view.navigationItem.largeTitleDisplayMode = .automatic
        return view
    }
    
    func navigateToSetting() -> UINavigationController {
        let view = UINavigationController(rootViewController: SettingScreenRouter().showView())
        view.tabBarItem = UITabBarItem(title: "Settings",
                                                image: UIImage(systemName: "gear"),
                                                tag: 3
        )
        view.navigationBar.prefersLargeTitles = true
        view.navigationItem.largeTitleDisplayMode = .automatic
        return view
    }
    
    func tabbarController() -> [UIViewController] {
        return [navigateToCharacter(), navigateToEpisode(), navigateToLocation(), navigateToSetting()]
    }
}

