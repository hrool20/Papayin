//
//  TVShowDetailViewController.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/9/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import SkeletonView

class TVShowDetailViewController: UIViewController {

    @IBOutlet weak var tvShowImageView: UIImageView!
    @IBOutlet weak var tvShowNameLabel: UILabel!
    @IBOutlet weak var tvShowCategoriesLabel: UILabel!
    @IBOutlet weak var seeVideosButton: UIButton!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var createdByTitleLabel: UILabel!
    @IBOutlet weak var castContainerView: UIView!
    @IBOutlet weak var seasonsTitleLabel: UILabel!
    @IBOutlet weak var seasonsContainerView: UIView!
    @IBOutlet weak var seasonContainerViewHeight: NSLayoutConstraint!
    private var tvShowDetailViewModel: TVShowDetailViewModel!
    var tvShowId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Detail"
        
        self.showSkeletonAnimation()
        
        self.getTVShowDetail()
    }
    
    @IBAction func didSeeVideos(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showVideos", sender: nil)
    }
    
    func showSkeletonAnimation() -> Void {
        let gradient = SkeletonGradient(baseColor: UIColor("#EFEFEF") ?? .gray)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 1)
        [self.tvShowNameLabel, tvShowCategoriesLabel].forEach { (label) in
            label?.linesCornerRadius = 5
        }
        [self.tvShowImageView, self.tvShowNameLabel, self.tvShowCategoriesLabel, self.overviewTextView].forEach { (view) in
            view?.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        }
        [self.seeVideosButton].forEach { (view) in
            view?.isHidden = true
        }
    }
    
    func hideSkeletonAnimation() -> Void {
        [self.seeVideosButton].forEach { (view) in
            view?.isHidden = false
        }
        [self.tvShowNameLabel, self.tvShowCategoriesLabel, self.overviewTextView].forEach { (view) in
            view?.hideSkeleton()
        }
    }
    
    func getTVShowDetail() -> Void {
        TVShowService.shared.getTVShowDetail(tvShowId: self.tvShowId,
        successCompletion: { (tvShow) in
            self.hideSkeletonAnimation()
            
            self.tvShowDetailViewModel = TVShowDetailViewModel(tvShow: tvShow)
            
            if let imageUrl = URL(string: self.tvShowDetailViewModel.image) {
                self.tvShowImageView.setImage(withUrl: imageUrl, placeholderImage: nil, completion: {
                    self.tvShowImageView.hideSkeleton()
                })
            }
            self.tvShowNameLabel.text = self.tvShowDetailViewModel.name
            self.tvShowCategoriesLabel.text = self.tvShowDetailViewModel.categories
            self.overviewTextView.text = self.tvShowDetailViewModel.overview
            if let castViewController = self.childViewControllers.first as? CastCollectionViewController {
                let castViewModels = self.tvShowDetailViewModel.cast.map({ (cast) -> CastViewModel in
                    return CastViewModel(cast: cast)
                })
                castViewController.castViewModels = castViewModels
            }
            if let seasonViewController = self.childViewControllers.last as? SeasonCollectionViewController {
                let seasonViewModels = self.tvShowDetailViewModel.seasons.map({ (season) -> SeasonViewModel in
                    return SeasonViewModel(season: season)
                })
                seasonViewController.seasonViewModels = seasonViewModels
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
            let viewController = segue.destination as! SeeVideosViewController
            viewController.tvShowId = self.tvShowId
        default:
            break
        }
    }

}
