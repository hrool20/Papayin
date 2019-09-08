//
//  MovieDetailViewController.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import SkeletonView

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var seeTrailerButton: UIButton!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var companiesProductionContainerView: UIView!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var productionCountriesLabel: UILabel!
    @IBOutlet weak var castContainerView: UIView!
    private var movie: Movie!
    var movieId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Detail"
        
        self.showSkeletonAnimation()
    }
    
    func getMovieDetail() -> Void {
        MovieService.shared.getMovieDetail(movieId: movieId,
        successCompletion: { (movie) in
            self.hideSkeletonAnimation()
            
            self.movie = movie
            
        }) { (error) in
            // MARK: Make an action
        }
    }
    
    func showSkeletonAnimation() -> Void {
        let gradient = SkeletonGradient(baseColor: UIColor("#EFEFEF") ?? .gray)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 1)
        self.movieNameLabel.linesCornerRadius = 5
        [self.movieImageView, self.movieNameLabel, self.overviewTextView, self.releaseLabel, self.genresLabel, self.runtimeLabel, self.revenueLabel, self.budgetLabel, self.productionCountriesLabel].forEach { (view) in
            view?.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        }
        [self.seeTrailerButton].forEach { (view) in
            view?.isHidden = true
        }
    }
    
    func hideSkeletonAnimation() -> Void {
        [self.seeTrailerButton].forEach { (view) in
            view?.isHidden = false
        }
        [self.movieNameLabel].forEach { (view) in
            view?.hideSkeleton()
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

}
