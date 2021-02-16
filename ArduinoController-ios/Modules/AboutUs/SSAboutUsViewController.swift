//
//  SSAboutUsViewController.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/12/21.
//

import UIKit
import MessageUI

class SSAboutUsViewController: UIViewController {

    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var creatorLabel: UILabel!
    
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var githubImageView: UIImageView!
    @IBOutlet weak var twitterImageView: UIImageView!
    @IBOutlet weak var telegramImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let versionNumber = Bundle.main.object(forInfoDictionaryKey:  (kCFBundleVersionKey as String) ) as? String
        versionLabel.text = versionNumber ?? "---"
        
        creatorLabel.text = "Saee Saadat"
        
        setupIcons()
    }
    
    private func setupIcons() {
        
        let eTap = UITapGestureRecognizer(target: self, action: #selector(self.mailTap))
        let giTap = UITapGestureRecognizer(target: self, action: #selector(self.gitTap))
        let telTap = UITapGestureRecognizer(target: self, action: #selector(self.teleTap))
        let twitTap = UITapGestureRecognizer(target: self, action: #selector(self.twiTap))
        
        emailImageView.addGestureRecognizer(eTap)
        githubImageView.addGestureRecognizer(giTap)
        telegramImageView.addGestureRecognizer(telTap)
        twitterImageView.addGestureRecognizer(twitTap)
        
        
    }
    
    @objc private func mailTap() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["saee_saadat@outlook.com"])
            mail.setSubject("Arduino controller iOS-client")
            present(mail, animated: true)
        } else {
            SSNavigationController.shared.showBottomPopUpAlert(withTitle: "Couldn't open Email compose view", alertState: .failure)
        }
    }
    
    @objc private func gitTap() {
        guard let url = URL(string: "https://github.com/SaeeSaadat") else {
            SSNavigationController.shared.showBottomPopUpAlert(withTitle: "Couldn't open Github Page! Just search my name tho! :)", alertState: .failure)
            return
        }
        UIApplication.shared.open(url)
    }
    
    @objc private func teleTap() {
        guard let url = URL(string: "https://t.me/SsAaEee") else {
            SSNavigationController.shared.showBottomPopUpAlert(withTitle: "Couldn't open Telegram! It's probably not meant to be :)", alertState: .failure)
            return
        }
        UIApplication.shared.open(url)
    }
    
    @objc private func twiTap() {
        guard let url = URL(string: "https://twitter.com/SaeeSaadat") else {
            SSNavigationController.shared.showBottomPopUpAlert(withTitle: "Couldn't open Twitter Page! You're not missing much tho! :)", alertState: .failure)
            return
        }
        UIApplication.shared.open(url)
    }
}

extension SSAboutUsViewController: MFMailComposeViewControllerDelegate {
    
}
