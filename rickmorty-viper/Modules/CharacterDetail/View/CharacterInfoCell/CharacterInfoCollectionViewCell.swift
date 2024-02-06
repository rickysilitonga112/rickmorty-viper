//
//  CharacterInfoCollectionViewCell.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 06/02/24.
//

import UIKit

class CharacterInfoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = String(describing: CharacterInfoCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        valueLabel.text = nil
        titleLabel.text = nil
    }
    
    private func setupLayer() {
        valueLabel.numberOfLines = 0
        titleContainerView.backgroundColor = .secondarySystemBackground
    }
    
    // MARK: - Public
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public func configure(with characterInfo: CharacterInfoEntity) {
        iconImageView.image = UIImage(systemName: characterInfo.type.iconName)
        titleLabel.text = characterInfo.type.displayTitle
        valueLabel.text = characterInfo.displayValue
        
        DispatchQueue.main.async {
            self.titleLabel.textColor = characterInfo.type.tintColor
            self.iconImageView.tintColor = characterInfo.type.tintColor
        }
    }

}
