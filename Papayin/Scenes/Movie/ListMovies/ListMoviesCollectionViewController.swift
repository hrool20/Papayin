//
//  ListMoviesCollectionViewController.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/5/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class ListMoviesCollectionViewController: UICollectionViewController {

    private var listMoviesViewModels: [ListMoviesViewModel]!
    private var isLoadedFromFirstTime: Bool!
    private let numberOfColumns: CGFloat! = 3.00
    private var page: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Movies"
        
        self.listMoviesViewModels = []
        self.isLoadedFromFirstTime = true
        self.page = 1
        
        self.getMovies {
            self.isLoadedFromFirstTime = false
        }
    }
    
    func getMovies(_ completion: (() -> Void)? = nil) -> Void {
        MovieService.shared.getMovies(page: self.page,
        successCompletion: { (movies) in
            let movieViewModels = movies.map({ (movie) -> ListMoviesViewModel in
                return ListMoviesViewModel(movie: movie)
            })
            self.listMoviesViewModels.append(contentsOf: movieViewModels)
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
        case "showMovieDetail":
            let viewController = segue.destination as! MovieDetailViewController
            viewController.movieId = sender as? Int
        default:
            break
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (!self.listMoviesViewModels.isEmpty && !self.isLoadedFromFirstTime) ? self.listMoviesViewModels.count : 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListMoviesCollectionViewCell.reuseIdentifier, for: indexPath) as? ListMoviesCollectionViewCell {
            guard !self.listMoviesViewModels.isEmpty else {
                return cell
            }
            cell.listMoviesViewModel = self.listMoviesViewModels[indexPath.row]
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showMovieDetail", sender: self.listMoviesViewModels[indexPath.row].movie.id)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard !self.listMoviesViewModels.isEmpty else {
            return
        }
        
        if indexPath.row == self.listMoviesViewModels.count - 1 {
            self.page += 1
            self.getMovies()
        }
    }

}
extension ListMoviesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let minimumScreenSize = (UIScreen.main.bounds.width < UIScreen.main.bounds.height) ? UIScreen.main.bounds.width : UIScreen.main.bounds.height
        let width = (minimumScreenSize / self.numberOfColumns) - (flowLayout.minimumInteritemSpacing * (self.numberOfColumns - 1))
        
        guard !self.listMoviesViewModels.isEmpty else {
            return CGSize(width: width, height: 200)
        }
        let listMoviesviewModel = self.listMoviesViewModels[indexPath.row]
        let approximateWidthOfLabel = width - 10 - 10
        let size = CGSize(width: approximateWidthOfLabel, height: 1000)
        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15)
        ]
        let estimatedFrame = NSString(string: listMoviesviewModel.title).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return CGSize(width: width, height: estimatedFrame.height + 190)
    }
}
