//
//  ListTVShowsCollectionViewCell.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import SkeletonView

class ListTVShowsCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return "tvShowViewCell"
    }
    @IBOutlet weak var tvShowImageView: UIImageView!
    @IBOutlet weak var tvShowNameLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var releaseDateImageView: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    var listTVShowsViewModel: ListTVShowsViewModel! {
        didSet {
            guard self.listTVShowsViewModel != nil else {
                return
            }
            
            self.hideSkeletonAnimation()
            
            if let imageUrl = URL(string: self.listTVShowsViewModel.image) {
                self.tvShowImageView.setImage(withUrl: imageUrl, placeholderImage: nil) {
                    self.tvShowImageView.hideSkeleton()
                    self.layoutSubviews()
                }
            }
            self.tvShowNameLabel.text = self.listTVShowsViewModel.title
            self.releaseDateLabel.text = self.listTVShowsViewModel.releaseDate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.showSkeletonAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 0.4
        self.tvShowImageView.layer.cornerRadius = 8
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.showSkeletonAnimation()
    }
    
    func showSkeletonAnimation() -> Void {
        let gradient = SkeletonGradient(baseColor: UIColor("#EFEFEF") ?? .gray)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 1)
        self.isUserInteractionEnabled = false
        [self.tvShowNameLabel, self.categoriesLabel].forEach { (label) in
            label?.linesCornerRadius = 5
        }
        [self.tvShowImageView, self.tvShowNameLabel, self.categoriesLabel].forEach { (view) in
            view?.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        }
        [self.releaseDateImageView, self.releaseDateLabel].forEach { (view) in
            view?.isHidden = true
        }
    }
    
    func hideSkeletonAnimation() -> Void {
        self.isUserInteractionEnabled = true
        [self.releaseDateImageView, self.releaseDateLabel].forEach { (view) in
            view?.isHidden = false
        }
        [self.tvShowNameLabel, self.categoriesLabel].forEach { (view) in
            view?.hideSkeleton()
        }
    }
    
}
