// 
//  SearchOptionPickerView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 16/02/24.
//

import UIKit

class SearchOptionPickerView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var option: DynamicOption!
    var presenter: SearchOptionPickerPresenter?
    var delegation: SearchViewDelegation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension SearchOptionPickerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegation?.didChooseOption(option, choice: option.choices[indexPath.row])
        dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let option = option else { return 0 }
        return option.choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = option?.choices[indexPath.row].uppercased()
        return cell
    }
}
