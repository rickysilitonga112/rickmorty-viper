// 
//  EpisodeDetailView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 07/02/24.
//

import UIKit
import RxSwift

class EpisodeDetailView: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let bag = DisposeBag()
    
    var episode: Episode?
    var presenter: EpisodeDetailPresenter?
    private var sections: [EpisodeDetailSection] = []
    private var characters: [Character] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Episode Detail"
        navigationItem.largeTitleDisplayMode = .never
        
        if let episode = episode {
            print("URL \(episode.url)")
        }
        
        fetchCharacters()
        setupSections()
        setupCollectionView()
    }

    static func instance(withPresenter presenter: EpisodeDetailPresenter) -> EpisodeDetailView {
        let storyboardId = String(describing: EpisodeDetailView.self)
        let storyboard = UIStoryboard(name: storyboardId, bundle: nil)
        guard let anyView = storyboard.instantiateViewController(withIdentifier: storyboardId) as? EpisodeDetailView else {
            fatalError("Error loading Storyboard")
        }
        anyView.presenter = presenter
        return anyView
    }
    
    // MARK: - Private
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        collectionView.collectionViewLayout = layout
        
        collectionView.register(SingleInfoCollectionViewCell.nib(), forCellWithReuseIdentifier: SingleInfoCollectionViewCell.identifier)
        collectionView.register(CharacterCollectionViewCell.nib(), forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
    }
    
    private func setupSections() {
        guard let episode = episode else {
            return
        }
        
        var createdString = episode.created
        if let date = CharacterInfoEntity.dateFormatter.date(from: episode.created) {
            createdString = CharacterInfoEntity.shortDateFormatter.string(from: date)
        }
        
        self.sections = [
            .info(infoCells: [
                .init(title: "Episode Name", value: episode.name),
                .init(title: "Air Date", value: episode.air_date),
                .init(title: "Episode", value: episode.episode),
                .init(title: "Created", value: createdString)
            ]),
            .characters(characters: characters.compactMap({ $0 }))
        ]
    }
    
    private func fetchCharacters() {
        guard let presenter = presenter,
              let episode = episode else {
            return
        }
        
        
        for urlString in episode.characters {
            presenter.fetchCharacter(from: URL(string: urlString))
                .asObservable()
                .subscribe { [weak self] character in
                    
                    if let character = character {
                        self?.characters.append(character)
                    }
                } onError: { error in
                    print(String(describing: error))
                }
                .disposed(by: bag)

        }
    }
}

extension EpisodeDetailView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let presenter = presenter,
              let navigation = navigationController else {
            return
        }
        
        let section = sections[indexPath.section]
        
        switch section {
        case .info:
            break
        case .characters:
            let character = characters[indexPath.row]
            presenter.navigateToDetailCharacter(from: navigation, with: characters[indexPath.row])
        }
    }
    
}

extension EpisodeDetailView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        
        switch section {
        case .info(let cells):
            return cells.count
        case .characters:
            return characters.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        
        switch section {
        case .info(let cells):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SingleInfoCollectionViewCell.identifier, for: indexPath) as? SingleInfoCollectionViewCell else {
                fatalError("Error cast SingleInfoCollectionViewCell")
            }
            cell.configure(with: cells[indexPath.row])
            return cell
        case .characters:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell else {
                fatalError("Error cast SingleInfoCollectionViewCell")
            }
            cell.configure(with: self.characters[indexPath.row])
            return cell
        }
    }
}

// MARK: EpisodeDetailLayout
extension EpisodeDetailView {
    func createSection(for section: Int) -> NSCollectionLayoutSection {
        switch sections[section] {
        case .info:
            return createInfoLayout()
        case .characters:
            return createCharacterLayout()
        }
    }
    
    func createInfoLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(80)),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func createCharacterLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
                )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 10,
            bottom: 5,
            trailing: 10
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(260)),
            subitems: [item, item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
