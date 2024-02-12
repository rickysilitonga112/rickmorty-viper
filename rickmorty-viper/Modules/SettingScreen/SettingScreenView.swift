// 
//  SettingScreenView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 26/01/24.
//

import UIKit
import StoreKit

class SettingScreenView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: SettingScreenPresenter?
    private var sections: [SettingSectionType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = "Setting"
        view.backgroundColor = .systemBackground
        
        setupSections()
        setupTableView()
    }
    
    private func setupSections() {
        for sectionType in SettingSectionType.allCases {
            sections.append(sectionType)
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
        tableView.register(SingleSettingTableViewCell.nib(), forCellReuseIdentifier: SingleSettingTableViewCell.identifier)
    }
    
}

extension SettingScreenView: UITableViewDelegate, UITableViewDataSource {
    // to set the cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = sections[indexPath.row]
        
        switch section {
        case .rateApp:
            if let scene = UIApplication.shared.connectedScenes.first {
                SKStoreReviewController.requestReview(in: scene as! UIWindowScene)
            }
        case .apiReference, .code, .contact,
                .series, .terms, .privacy :
            guard let url = section.optionUrl else { return }
            UIApplication.shared.open(url)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SingleSettingTableViewCell.identifier, for: indexPath) as? SingleSettingTableViewCell else {
            fatalError("Error parse SingleSettingTableViewCell")
        }
        cell.configure(with: sections[indexPath.row])
        return cell
    }
}

