//
//  SSControlArduinoViewController.swift
//  ArduinoController-ios
//
//  Created by Saee Saadat on 2/17/21.
//

import UIKit

class SSControlArduinoViewController: UIViewController {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var functions: [SSArduinoFunction] = []
    
    override func viewDidLoad() {
            super.viewDidLoad()

            setupView()
        }

        private func setupView() {
            
            setupCollectionView()
            
        }
        
        private func setupCollectionView() {
            collectionView.register(UINib(nibName: "SSArduinoFunctionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "controllerCell")
            collectionView.delegate = self
            collectionView.dataSource = self
        }

}

extension SSControlArduinoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return functions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "controllerCell", for: indexPath) as? SSArduinoFunctionCollectionViewCell
            else { return UICollectionViewCell() }
        return cell
    }
    
    
}
