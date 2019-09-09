//
//  ProductionCompanyCollectionViewController.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class ProductionCompanyCollectionViewController: UICollectionViewController {

    var ProductionCompanyViewModels: [ProductionCompanyViewModel]! {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    private var isLoadedFromFirstTime: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.ProductionCompanyViewModels = []
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
        return (!self.ProductionCompanyViewModels.isEmpty && !self.isLoadedFromFirstTime) ? self.ProductionCompanyViewModels.count : 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductionCompanyCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductionCompanyCollectionViewCell {
            guard !self.ProductionCompanyViewModels.isEmpty else {
                return cell
            }
            cell.ProductionCompanyViewModel = self.ProductionCompanyViewModels[indexPath.row]
            
            return cell
        }
        
        return UICollectionViewCell()
    }

}
