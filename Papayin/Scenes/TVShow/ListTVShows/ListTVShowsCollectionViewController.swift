//
//  ListTVShowsCollectionViewController.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class ListTVShowsCollectionViewController: UICollectionViewController {

    private var listTVShowsViewModels: [ListTVShowsViewModel]!
    private var isLoadedFromFirstTime: Bool!
    private var page: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "TV Shows"
        
        self.listTVShowsViewModels = []
        self.isLoadedFromFirstTime = true
        self.page = 1
        
        self.getTVShows {
            self.isLoadedFromFirstTime = false
        }
    }
    
    func getTVShows(_ completion: (() -> Void)? = nil) -> Void {
        TVShowService.shared.getTVShows(page: self.page,
        successCompletion: { (tvShows) in
            self.listTVShowsViewModels = tvShows.map({ (tvShow) -> ListTVShowsViewModel in
                return ListTVShowsViewModel(tvShow: tvShow)
            })
            completion?()
            self.collectionView?.reloadData()
        }) { (error) in
            // MARK: Make an action
            completion?()
        }
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
        return (!self.listTVShowsViewModels.isEmpty && !self.isLoadedFromFirstTime) ? self.listTVShowsViewModels.count : 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListTVShowsCollectionViewCell.reuseIdentifier, for: indexPath) as? ListTVShowsCollectionViewCell {
            guard !self.listTVShowsViewModels.isEmpty else {
                return cell
            }
            cell.listTVShowsViewModel = self.listTVShowsViewModels[indexPath.row]
            
            return cell
        }
        
        return UICollectionViewCell()
    }

}
extension ListTVShowsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let width = UIScreen.main.bounds.width - 30
        
        guard !self.listTVShowsViewModels.isEmpty else {
            return CGSize(width: width, height: 150)
        }
        
        return CGSize(width: width, height: 150)
    }
}
