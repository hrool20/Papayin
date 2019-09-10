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
            let tvShowViewModels = tvShows.map({ (tvShow) -> ListTVShowsViewModel in
                return ListTVShowsViewModel(tvShow: tvShow)
            })
            self.listTVShowsViewModels.append(contentsOf: tvShowViewModels)
            completion?()
            self.collectionView?.reloadData()
        }) { (error) in
            // MARK: Make an action
            completion?()
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTVDetail":
            let viewController = segue.destination as! TVShowDetailViewController
            viewController.tvShowId = sender as? Int
        default:
            break
        }
    }

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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showTVDetail", sender: self.listTVShowsViewModels[indexPath.row].tvShow.id)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard !self.listTVShowsViewModels.isEmpty else {
            return
        }
        
        if indexPath.row == self.listTVShowsViewModels.count - 1 {
            self.page += 1
            self.getTVShows()
        }
    }

}
extension ListTVShowsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let width = UIScreen.main.bounds.width - 30
        
        guard !self.listTVShowsViewModels.isEmpty else {
            return CGSize(width: width, height: flowLayout.itemSize.height)
        }
        
        return CGSize(width: width, height: flowLayout.itemSize.height)
    }
}
