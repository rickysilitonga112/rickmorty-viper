//
//  SingleInfoCollectionViewCell.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 06/02/24.
//

import UIKit

class SingleInfoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    static let identifier = String(describing: SingleInfoCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    private func setupLayer() {
        contentView.backgroundColor = .secondarySystemBackground
        
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        
        layer.shadowColor = UIColor.secondaryLabel.cgColor
        layer.shadowOffset = CGSize(width: -4, height: 4)
        layer.masksToBounds = false
        layer.shadowOpacity = 0.3
        
        titleLabel.textAlignment = .left
    
        valueLabel.textAlignment = .right
        valueLabel.numberOfLines = 0
    }
    
    // MARK: - Public
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public func configure(with data: SingleCellEntity) {
        titleLabel.text = data.title
        valueLabel.text = data.value
    }

}
