//
//  SSSingleButtonTableViewCell.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/18/21.
//

import UIKit

class SSSingleButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    var buttonCallback: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(title: String, callBack: (() -> Void)?) {
        self.buttonCallback = callBack
        button.setTitle(title.localized, for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {}
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    
    @IBAction func pressed(_ sender: Any) {
        self.buttonCallback?()
    }
}
