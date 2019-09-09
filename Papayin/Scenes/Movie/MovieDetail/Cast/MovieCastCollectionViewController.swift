//
//  MovieCastCollectionViewController.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class MovieCastCollectionViewController: UICollectionViewController {

    var movieCastViewModels: [MovieCastViewModel]! {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    private var isLoadedFromFirstTime: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.movieCastViewModels = []
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
        return (!self.movieCastViewModels.isEmpty && !self.isLoadedFromFirstTime) ? self.movieCastViewModels.count : 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCastCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieCastCollectionViewCell {
            guard !self.movieCastViewModels.isEmpty else {
                return cell
            }
            cell.movieCastViewModel = self.movieCastViewModels[indexPath.row]
            
            return cell
        }
        
        return UICollectionViewCell()
    }

}
