//
//  PopularContentCollectionViewController.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/9/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class PopularContentCollectionViewController: UICollectionViewController {

    var popularContentViewModels: [PopularContentViewModel]! {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    var type: MainViewControllerType! {
        didSet {
            switch self.type {
            case .movie?:
                self.getPopularMovies {
                    self.isLoadedFromFirstTime = false
                }
            case .tv?:
                self.getPopularTVShows {
                    self.isLoadedFromFirstTime = false
                }
            default:
                break
            }
        }
    }
    var cellHeight: CGFloat!
    private var isLoadedFromFirstTime: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.popularContentViewModels = []
        self.isLoadedFromFirstTime = true
    }
    
    func getPopularMovies(_ completion: (() -> Void)? = nil) -> Void {
        MovieService.shared.getPopularMovies(successCompletion: { (movies) in
            let movieViewModels = movies.map({ (movie) -> PopularContentViewModel in
                return PopularContentViewModel(movie: movie)
            })
            completion?()
            self.popularContentViewModels.append(contentsOf: movieViewModels)
        }) { (error) in
            // MARK: Make an action
        }
    }
    
    func getPopularTVShows(_ completion: (() -> Void)? = nil) -> Void {
        TVShowService.shared.getPopularTVshows(successCompletion: { (tvShows) in
            let tvShowViewModels = tvShows.map({ (tvShow) -> PopularContentViewModel in
                return PopularContentViewModel(tvShow: tvShow)
            })
            completion?()
            self.popularContentViewModels.append(contentsOf: tvShowViewModels)
        }) { (error) in
            // MARK: Make an action
        }
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (!self.popularContentViewModels.isEmpty && !self.isLoadedFromFirstTime) ? self.popularContentViewModels.count : 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularContentCollectionViewCell.reuseIdentifier, for: indexPath) as? PopularContentCollectionViewCell {
            guard !self.popularContentViewModels.isEmpty else {
                return cell
            }
            cell.popularContentViewModel = self.popularContentViewModels[indexPath.row]
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch self.parent {
        case let vc as MainViewController:
            switch self.type {
            case .movie?:
                vc.performSegue(withIdentifier: "showMovieDetail", sender: self.popularContentViewModels[indexPath.row].id)
            case .tv?:
                vc.performSegue(withIdentifier: "showTVDetail", sender: self.popularContentViewModels[indexPath.row].id)
            default:
                break
            }
        default:
            break
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }

}
extension PopularContentCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        guard self.cellHeight != nil && self.cellHeight != 0 else {
            return flowLayout.itemSize
        }
        
        let cellWidth = (self.cellHeight * 17) / 37
        return CGSize(width: cellWidth, height: self.cellHeight)
    }
}
