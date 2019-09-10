//
//  CastCollectionViewController.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class CastCollectionViewController: UICollectionViewController {

    var castViewModels: [CastViewModel]! {
        didSet {
            self.isLoadedFromFirstTime = false
            self.collectionView?.reloadData()
        }
    }
    private var isLoadedFromFirstTime: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.castViewModels = []
        self.isLoadedFromFirstTime = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (!self.castViewModels.isEmpty && !self.isLoadedFromFirstTime) ? self.castViewModels.count : 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.reuseIdentifier, for: indexPath) as? CastCollectionViewCell {
            guard !self.castViewModels.isEmpty else {
                return cell
            }
            cell.castViewModel = self.castViewModels[indexPath.row]
            
            return cell
        }
        
        return UICollectionViewCell()
    }

}
