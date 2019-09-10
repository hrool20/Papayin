//
//  SeasonCollectionViewCell.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/9/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import SkeletonView

class SeasonCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return "seasonViewCell"
    }
    @IBOutlet weak var seasonImageView: UIImageView!
    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var airDateTitleLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    var seasonViewModel: SeasonViewModel! {
        didSet {
            guard self.seasonViewModel != nil else {
                return
            }
            
            self.hideSkeletonAnimation()
            
            if let imageUrl = URL(string: self.seasonViewModel.image) {
                self.seasonImageView.setImage(withUrl: imageUrl, placeholderImage: nil) {
                    self.seasonImageView.hideSkeleton()
                    self.layoutSubviews()
                }
            }
            self.seasonNameLabel.text = self.seasonViewModel.name
            self.overviewTextView.text = self.seasonViewModel.overview
            self.episodeNumberLabel.text = self.seasonViewModel.episodeNumber
            self.airDateLabel.text = self.seasonViewModel.airDate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.showSkeletonAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.seasonImageView.layer.cornerRadius = self.seasonImageView.bounds.width / 15
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.showSkeletonAnimation()
    }
    
    func showSkeletonAnimation() -> Void {
        let gradient = SkeletonGradient(baseColor: UIColor("#EFEFEF") ?? .gray)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 1)
        self.isUserInteractionEnabled = false
        [self.seasonNameLabel, self.episodeNumberLabel, self.airDateLabel].forEach { (label) in
            label?.linesCornerRadius = 5
        }
        self.overviewTextView.linesCornerRadius = 5
        [self.seasonImageView, self.seasonNameLabel].forEach { (view) in
            view?.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        }
        [self.overviewTextView, self.episodeTitleLabel, self.episodeNumberLabel, self.airDateTitleLabel, self.airDateLabel].forEach { (view) in
            view?.isHidden = true
        }
    }
    
    func hideSkeletonAnimation() -> Void {
        self.isUserInteractionEnabled = true
        [self.overviewTextView, self.episodeTitleLabel, self.episodeNumberLabel, self.airDateTitleLabel, self.airDateLabel].forEach { (view) in
            view?.isHidden = false
        }
        [self.seasonNameLabel].forEach { (view) in
            view?.hideSkeleton()
        }
    }
    
}
