//
//  MainViewController.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/9/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

enum MainViewControllerType: String {
    case movie = "movie"
    case tv = "tvShow"
}

class MainViewController: UIViewController {

    @IBOutlet weak var popularMoviesContainerView: UIView!
    @IBOutlet weak var popularTVShowsContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Home"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("Movie: \(self.popularMoviesContainerView.bounds.height)")
        print("TVShow: \(self.popularTVShowsContainerView.bounds.height)")
        if let movieViewController = self.childViewControllers.first as? PopularContentCollectionViewController {
            movieViewController.cellHeight = self.popularMoviesContainerView.bounds.height - 20
            movieViewController.type = .movie
        }
        
        if let tvShowViewController = self.childViewControllers.last as? PopularContentCollectionViewController {
            tvShowViewController.cellHeight = self.popularTVShowsContainerView.bounds.height - 20
            tvShowViewController.type = .tv
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showMovieDetail":
            let viewController = segue.destination as! MovieDetailViewController
            viewController.movieId = sender as? Int
        case "showTVDetail":
            let viewController = segue.destination as! TVShowDetailViewController
            viewController.tvShowId = sender as? Int
        default:
            break
        }
    }

}
