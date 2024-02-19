// 
//  SearchInputView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 12/02/24.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources


protocol SearchViewDelegation {
    func didChooseOption(_ option: DynamicOption, choice: String)
}

class SearchView: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var containerToSearchConstraint: NSLayoutConstraint!
    
    private let bag = DisposeBag()
    private var searchText = ""
    private var stackView: UIStackView?
    private var searchResults: [Any] = []
    private var searchOptions: [DynamicOption] = []
    private var optionMap: [DynamicOption: String] = [:]
    
    var searchType: SearchType?
    var presenter: SearchPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let searchType = searchType {
            if searchType != .episode {
                containerToSearchConstraint.constant = 50
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapExecuteSearch)
        )
        setupView()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == Segues.toSearchResultView {
            let destVC = segue.destination as! SearchResultViewController
            destVC.view.backgroundColor = .systemMint
        }
    }

    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        title = "Search"
        
        setupSearchBar()
        setupStackView()
    }
    
    // search bar
    private func setupSearchBar() {
        searchBar.delegate = self
        
        searchBar.becomeFirstResponder()
        if let type = searchType {
            searchBar.placeholder = type.title
        }
    }
    
    private func setupStackView() {
        if let searchType = searchType {
            createDynamicOption(from: searchType)
        }
    }
    
    // create dynamic option stackView
    private func createDynamicOption(from type: SearchType) {
        guard let presenter = presenter else { return }
        
        let stackView = createOptionStackView()
        self.stackView = stackView
        
        self.searchOptions = presenter.createOptions(from: type)
        
        for (index, option) in searchOptions.enumerated() {
            let button = createButton(with: option, index: index)
            stackView.addArrangedSubview(button)
        }

    }
    
    private func createButton(with option: DynamicOption, index tag: Int) -> UIButton {
        let button = UIButton()
        
        let attributedString = NSAttributedString(
            string: option.rawValue, 
            attributes: [
                .font: UIFont.systemFont(ofSize: 18, weight: .medium),
                .foregroundColor: UIColor.label
            ]
        )
        button.tag = tag
        button.layer.cornerRadius = 6
        button.backgroundColor = .secondarySystemBackground
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(didTapOptionButton(_:)), for: .touchUpInside)
        return button
    }
    
    private func createOptionStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 6
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: (searchType == .episode) ? 0 : 50)
        ])
        return stackView
    }
    
    private func updateDynamicButtonText(_ option: DynamicOption, to text: String) {
        guard let buttons = stackView?.arrangedSubviews,
              let index = searchOptions.firstIndex(of: option) else {
            return
        }
        
        let button: UIButton = buttons[index] as! UIButton
        let attributedString = NSAttributedString(
            string: option.rawValue,
            attributes: [
                .font: UIFont.systemFont(ofSize: 18, weight: .medium),
                .foregroundColor: UIColor.link
            ]
        )
        button.setAttributedTitle(attributedString, for: .normal)
    }
    
    private func processSearchResult() {
        
    }
    
    @objc
    private func didTapOptionButton(_ sender: UIButton) {
        guard let presenter = presenter,
              let navigation = navigationController else {
            return
        }
        let option = searchOptions[sender.tag]
        presenter.showBottomSheetOptionChoices(on: navigation, with: option, delegation: self)
    }
    
    @objc
    private func didTapExecuteSearch() {
        guard let presenter = presenter,
              let searchType = searchType,
              !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        let queryParams = presenter.createSearchParameter(searchText: searchText, optionMap: optionMap)
        
        // TODO: CHANGE TO OBSERVABLE
//        presenter.executeSearch(endpoint: searchType.endpoint, params: queryParams)
        switch searchType.endpoint {
        case .character:
            presenter.executeFetchCharacter(params: queryParams)
                .asObservable()
                .subscribe { entity in
                    if let entity = entity {
                        
                    }
                } onError: { error in
                    fatalError(error.localizedDescription)
                }.disposed(by: bag)
        case .location:
            presenter.executeFetchCharacter(params: queryParams)
                .asObservable()
                .subscribe { entity in
                    if let entity = entity {
                        
                    }
                } onError: { error in
                    fatalError(error.localizedDescription)
                }.disposed(by: bag)
        case .episode:
            presenter.executeFetchCharacter(params: queryParams)
                .asObservable()
                .subscribe { entity in
                    if let entity = entity {
                        
                    }
                } onError: { error in
                    fatalError(error.localizedDescription)
                }.disposed(by: bag)
        }
    }
}

// MARK: - UISearchBarDelegate
extension SearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchBar.text!
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}


extension SearchView: SearchViewDelegation {
    func didChooseOption(_ option: DynamicOption, choice: String) {
        updateDynamicButtonText(option, to: choice)
        optionMap[option] = choice
    }
}
