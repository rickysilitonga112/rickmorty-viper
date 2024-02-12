//
//  LocationDetailView.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 11/02/24.
//

import UIKit
import RxSwift

class LocationDetailView: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let bag = DisposeBag()
    private var sections: [LocationDetailSection] = []
    private var characters: [Character] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var presenter: LocationDetailPresenter?
    var location: Location?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Location Detail"
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        
        fetchCharacters()
        setupSections()
        setupCollectionView()
    }
    
    // MARK: - Private
    private func fetchCharacters() {
        guard let presenter = presenter,
              let location = location else {
            return
        }
        
        for urlString in location.residents {
            presenter.fetchCharacter(with: URL(string: urlString))
                .asObservable()
                .subscribe { [weak self] character in
                    if let character = character {
                        self?.characters.append(character)
                    }
                } onError: { error in
                    print(String(describing: error))
                } .disposed(by: bag)
        }
    }
    
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
        guard let location = location else { return }
        var createdString = location.created
        if let date = CharacterInfoEntity.dateFormatter.date(from: location.created) {
            createdString = CharacterInfoEntity.shortDateFormatter.string(from: date)
        }
        self.sections = [
            .info(infoCells: [
                SingleCellEntity(title: "Name", value: location.name),
                SingleCellEntity(title: "Type", value: location.type),
                SingleCellEntity(title: "Dimension", value: location.dimension),
                SingleCellEntity(title: "Created", value: createdString)
            ]),
            .characters(characters: characters.compactMap({ $0 }))
        ]
    }
    
}

extension LocationDetailView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let section = sections[indexPath.section]
        switch section {
        case .info:
            break
        case .characters:
            guard let presenter = presenter,
                  let navigation = navigationController,
                  !characters.isEmpty else {
                return
            }
            presenter.navigateToDetailCharacter(from: navigation, with: characters[indexPath.row])
        }
    }
    
}

extension LocationDetailView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .info(let infoCells):
            return infoCells.count
        case .characters:
            return characters.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        
        switch section {
        case .info(let infoCells):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SingleInfoCollectionViewCell.identifier, for: indexPath) as? SingleInfoCollectionViewCell else {
                fatalError("Error parse SingleInfoCollectionViewCell")
            }
            cell.configure(with: infoCells[indexPath.row])
            return cell
            
        case .characters:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as? CharacterCollectionViewCell else {
                fatalError("Error parse CharacterCollectionViewCell")
            }
            cell.configure(with: characters[indexPath.row])
            return cell
        }
    }
}

// MARK: - CollectionView Layout
extension LocationDetailView {
    private func createSection(for section: Int) -> NSCollectionLayoutSection {
        switch sections[section] {
        case .info:
            return createInfoLayout()
        case .characters:
            return createCharacterLayout()
        }
    }
    
    private func createInfoLayout() -> NSCollectionLayoutSection{
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                heightDimension: NSCollectionLayoutDimension.fractionalHeight(1))
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0),
                                               heightDimension: NSCollectionLayoutDimension.absolute(80)),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createCharacterLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: NSCollectionLayoutDimension.fractionalWidth(0.5),
                heightDimension: NSCollectionLayoutDimension.fractionalHeight(1))
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5,
            leading: 10,
            bottom: 5,
            trailing: 10
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                                               heightDimension: NSCollectionLayoutDimension.absolute(260)),
            subitems: [item, item]
        )
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
}
