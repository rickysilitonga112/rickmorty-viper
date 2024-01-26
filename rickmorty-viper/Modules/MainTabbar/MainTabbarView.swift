//
//  MainTabbarView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit

class MainTabbarView: UITabBarController {

    var presenter: MainTabbarPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewControllers = MainTabbarRouter().tabbarController()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    static func instance(withPresenter presenter: MainTabbarPresenter) -> MainTabbarView {
        let storyboardId = String(describing: MainTabbarView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let anyView = storyboard.instantiateViewController(withIdentifier: storyboardId) as? MainTabbarView else {
            fatalError("Error loading Storyboard")
        }
        anyView.presenter = presenter
        return anyView
    }

}
