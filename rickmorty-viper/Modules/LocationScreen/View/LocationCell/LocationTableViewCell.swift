//
//  LocationTableViewCell.swift
//  rickmorty-viper
//
//  Created by Ricky Silitonga on 08/02/24.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
//    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dimensionLabel: UILabel!
    
    static let identifier = String(describing: LocationTableViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLayer()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        typeLabel.text = nil
        dimensionLabel.text = nil
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupLayer() {
        self.accessoryType = .disclosureIndicator
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0

        typeLabel.textAlignment = .left
        typeLabel.numberOfLines = 0

        dimensionLabel.textAlignment = .left
        dimensionLabel.numberOfLines = 0
        
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public func configure(with location: Location) {
        nameLabel.text = location.name
        typeLabel.text = location.type
        dimensionLabel.text = location.dimension
    }
    
}
