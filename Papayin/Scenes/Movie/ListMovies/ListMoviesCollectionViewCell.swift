//
//  ListMoviesCollectionViewCell.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/5/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import AlamofireImage
import SkeletonView

class ListMoviesCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return "movieViewCell"
    }
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    var listMoviesViewModel: ListMoviesViewModel! {
        didSet {
            guard self.listMoviesViewModel != nil else {
                return
            }
            
            self.hideSkeletonAnimation()
            
            if let imageUrl = URL(string: self.listMoviesViewModel.image) {
                self.movieImageView.setImage(withUrl: imageUrl, placeholderImage: nil) {
                    self.movieImageView.hideSkeleton()
                    self.layoutSubviews()
                }
            }
            self.movieNameLabel.text = self.listMoviesViewModel.title
            self.releaseDateLabel.text = self.listMoviesViewModel.releaseDate
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
        self.movieImageView.layer.cornerRadius = 8
    }
    
    func showSkeletonAnimation() -> Void {
        let gradient = SkeletonGradient(baseColor: UIColor("#EFEFEF") ?? .gray)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 1)
        self.movieNameLabel.linesCornerRadius = 5
        [self.movieImageView, self.movieNameLabel].forEach { (view) in
            view?.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        }
        [self.releaseDateLabel].forEach { (view) in
            view?.isHidden = true
        }
    }
    
    func hideSkeletonAnimation() -> Void {
        [self.releaseDateLabel].forEach { (view) in
            view?.isHidden = false
        }
        [self.movieNameLabel].forEach { (view) in
            view?.hideSkeleton()
        }
    }
}
