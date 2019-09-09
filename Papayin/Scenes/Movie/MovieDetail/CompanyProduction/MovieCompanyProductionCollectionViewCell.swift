//
//  MovieCompanyProductionCollectionViewCell.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import SkeletonView

class MovieCompanyProductionCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return "companyProductionViewCell"
    }
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    var movieCompanyProductionViewModel: MovieCompanyProductionViewModel! {
        didSet {
            guard self.movieCompanyProductionViewModel != nil else {
                return
            }
            
            self.hideSkeletonAnimation()
            
            if let imageUrl = URL(string: self.movieCompanyProductionViewModel.image) {
                self.companyImageView.setImage(withUrl: imageUrl, placeholderImage: nil) {
                    self.companyImageView.hideSkeleton()
                    self.layoutSubviews()
                }
            } else {
                self.companyImageView.image = #imageLiteral(resourceName: "movie_icon.png")
                self.companyImageView.hideSkeleton()
            }
            self.companyNameLabel.text = self.movieCompanyProductionViewModel.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.showSkeletonAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.companyImageView.layer.cornerRadius = self.companyImageView.bounds.height / 2
        self.companyImageView.layer.borderWidth = 0.7
        self.companyImageView.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.showSkeletonAnimation()
    }
    
    func showSkeletonAnimation() -> Void {
        let gradient = SkeletonGradient(baseColor: UIColor("#EFEFEF") ?? .gray)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 1)
        self.isUserInteractionEnabled = false
        self.companyNameLabel.linesCornerRadius = 5
        [self.companyImageView, self.companyNameLabel].forEach { (view) in
            view?.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        }
    }
    
    func hideSkeletonAnimation() -> Void {
        self.isUserInteractionEnabled = true
        [self.companyNameLabel].forEach { (view) in
            view?.hideSkeleton()
        }
    }
    
}
