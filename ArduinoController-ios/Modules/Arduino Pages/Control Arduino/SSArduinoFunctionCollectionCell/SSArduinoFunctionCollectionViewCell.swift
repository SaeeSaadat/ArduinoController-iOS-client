//
//  SSArduinoFunctionCollectionViewCell.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/17/21.
//

import UIKit
import JellyGif

class SSArduinoFunctionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var outterSquare: UIView!
    @IBOutlet weak var innerSquare: UIView!
    
    @IBOutlet weak var innerSquareHeight: NSLayoutConstraint!
    @IBOutlet weak var innerSquareWidth: NSLayoutConstraint!
    
    private var checkView: JellyGifImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(model: SSArduinoFunction, index: Int) {
        nameLabel.text = model.name
        
        let accentColor = (index % 2 == 0) ? SSColors.accent.color : SSColors.accent2.color
        nameLabel.textColor = accentColor
        innerSquare.backgroundColor = accentColor
        
        [innerSquare, outterSquare].forEach({
            $0?.layer.borderWidth = 2.0
            $0?.layer.borderColor = accentColor.cgColor
        })
        outterSquare.layer.cornerRadius = 20.0
        innerSquare.layer.cornerRadius = 10.0
        
        let checkView = JellyGifImageView()
        checkView.translatesAutoresizingMaskIntoConstraints = false
        self.innerSquare.addSubview(checkView)
        NSLayoutConstraint.activate([
            checkView.centerYAnchor.constraint(equalTo: innerSquare.centerYAnchor),
            checkView.centerXAnchor.constraint(equalTo: innerSquare.centerXAnchor),
            checkView.heightAnchor.constraint(equalToConstant: 80),
            checkView.widthAnchor.constraint(equalToConstant: 80)
        ])
        self.checkView = checkView
        checkView.isHidden = true
        checkView.alpha = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        innerSquareWidth.constant = selected ? 100 : 50
        innerSquareHeight.constant = selected ? 100 : 50
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.layoutIfNeeded()
        })
        
        if selected {
            //Send API
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.appearCheckView(true)
                self.receivedResponse()
            })
            
        }
    }

    private func receivedResponse() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.innerSquareWidth.constant =  50
            self.innerSquareHeight.constant = 50
            UIView.animate(withDuration: 0.2, animations: {
                self.contentView.layoutIfNeeded()
            })
            self.fadeCheckView()
        })
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        innerSquareWidth.constant = highlighted ? 20 : 50
        innerSquareHeight.constant = highlighted ? 20 : 50
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.layoutIfNeeded()
        })
        let scale: CGFloat = highlighted ? 0.95 : 1.0
        UIView.transition(with: self.innerView, duration: 0.05, options: [], animations: {
            self.innerView.transform = CGAffineTransform(scaleX: scale, y: scale).translatedBy(x: -10, y: -10)
        }, completion: nil)
    }
    
}

extension SSArduinoFunctionTableViewCell {
    private func fadeCheckView() {
        guard let check = self.checkView else {return}
        UIView.transition(with: check, duration: 0.2, options: [], animations: {
            check.alpha = 0
        }, completion: { _ in
            check.pauseGif()
            check.isHidden = true
        })
    }
    
    private func appearCheckView(_ successful: Bool) {
        guard let check = self.checkView else {return}
        check.isHidden = false
        self.checkView?.startGif(with: .name(successful ? "tick" : "xmark"))
        UIView.transition(with: check, duration: 0.2, options: [], animations: {
            check.alpha = 1
        }, completion: nil)
    }
}
