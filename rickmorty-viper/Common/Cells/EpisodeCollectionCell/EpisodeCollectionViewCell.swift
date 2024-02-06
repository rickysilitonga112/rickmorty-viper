//
//  EpisodeCollectionViewCell.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 05/02/24.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var airDataLabel: UILabel!
    
    static let identifier = String(describing: EpisodeCollectionViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        seasonLabel.text = nil
        nameLabel.text = nil
        airDataLabel.text = nil
    }

    // MARK: - Public
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public func configure() {
        
    }
    
}
