//
//  SSArduinoTableViewCell.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 1/27/21.
//

import UIKit

class SSArduinoTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var backgroundFIller: UIView!
    @IBOutlet weak var backgroundFillerHeightConstriant: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell( arduino: SSArduinoModel , isLast: Bool = false) {
        
        self.nameLabel.text = arduino.name ?? "-"
        self.modelLabel.text = arduino.model ?? "-"
        self.descLabel.text = arduino.description ?? "-"
        
        self.separatorView.isHidden = isLast
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)

        self.backgroundFillerHeightConstriant.constant = selected ? self.frame.height - 10 : 0

        UIView.animate(withDuration: 0.3 , animations: {

            self.layoutIfNeeded()
        })
        
        UIView.transition(with: nameLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.nameLabel.textColor = selected ? SSColors.accent2.color : SSColors.accent.color
        }, completion: nil)
        
    }
    
}
