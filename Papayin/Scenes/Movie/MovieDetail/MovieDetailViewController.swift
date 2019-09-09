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
    @IBOutlet weak var productionCompaniesContainerView: UIView!
    @IBOutlet weak var releaseTitleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var genresTitleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var runtimeTitleLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var revenueTitleLabel: UILabel!
    @IBOutlet weak var revenueLabel: UILabel!
    @IBOutlet weak var budgetTitleLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var productionCountriesTitleLabel: UILabel!
    @IBOutlet weak var productionCountriesLabel: UILabel!
    @IBOutlet weak var castContainerView: UIView!
    private var movieDetailViewModel: MovieDetailViewModel!
    var movieId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Detail"
        
        self.showSkeletonAnimation()
        
        self.getMovieDetail {
            self.getMovieCast()
        }
    }
    
    @IBAction func showTrailerPopup(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showVideos", sender: nil)
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
        [self.movieNameLabel, self.overviewTextView, self.releaseLabel, self.genresLabel, self.runtimeLabel, self.revenueLabel, self.budgetLabel, self.productionCountriesLabel].forEach { (view) in
            view?.hideSkeleton()
        }
    }
    
    func getMovieDetail(_ completion: (() -> Void)? = nil) -> Void {
        MovieService.shared.getMovieDetail(movieId: self.movieId,
        successCompletion: { (movie) in
            self.hideSkeletonAnimation()
            
            self.movieDetailViewModel = MovieDetailViewModel(movie: movie)
            
            if let imageUrl = URL(string: self.movieDetailViewModel.image) {
                self.movieImageView.setImage(withUrl: imageUrl, placeholderImage: nil, completion: {
                    self.movieImageView.hideSkeleton()
                })
            }
            self.movieNameLabel.text = self.movieDetailViewModel.name
            self.overviewTextView.text = self.movieDetailViewModel.overview
            if let companyViewController = self.childViewControllers.first as? MovieCompanyProductionCollectionViewController {
                companyViewController.movieCompanyProductionViewModels = self.movieDetailViewModel.productionCompanies
            }
            self.releaseLabel.text = self.movieDetailViewModel.releaseDate
            self.genresLabel.text = self.movieDetailViewModel.genres
            self.runtimeLabel.text = self.movieDetailViewModel.runtime
            self.revenueLabel.text = self.movieDetailViewModel.revenue
            self.budgetLabel.text = self.movieDetailViewModel.budget
            self.productionCountriesLabel.text = self.movieDetailViewModel.productionCountries
            completion?()
        }) { (error) in
            // MARK: Make an action
        }
    }
    
    func getMovieCast() -> Void {
        MovieService.shared.getMovieCast(movieId: self.movieId,
        successCompletion: { (cast) in
            let movieCastViewModels = cast.map({ (aux) -> MovieCastViewModel in
                return MovieCastViewModel(cast: aux)
            })
            if let castViewController = self.childViewControllers.last as? MovieCastCollectionViewController {
                castViewController.movieCastViewModels = movieCastViewModels
            }
        }) { (error) in
            // MARK: Make an action
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showVideos":
            let vc = segue.destination as! SeeVideosViewController
            vc.movieId = self.movieId
        default:
            break
        }
    }

}
