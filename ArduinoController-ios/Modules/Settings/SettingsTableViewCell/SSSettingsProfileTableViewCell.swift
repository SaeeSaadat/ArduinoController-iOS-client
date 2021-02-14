//
//  SSSettingsProfileTableViewCell.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/15/21.
//

import UIKit

class SSSettingsProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(image: UIImage?) {
        profileImageView.image = image ?? UIImage(named: "Mini-Robot")
        profileImageView.layer.cornerRadius = 100
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 5.0
        profileImageView.layer.borderColor = SSColors.accent.color.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
