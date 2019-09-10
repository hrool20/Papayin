//
//  PopularContentCollectionViewCell.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/9/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import SkeletonView

class PopularContentCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return "popularContentViewCell"
    }
    @IBOutlet weak var popularContentImageView: UIImageView!
    var popularContentViewModel: PopularContentViewModel! {
        didSet {
            guard self.popularContentViewModel != nil else {
                return
            }
            
            self.hideSkeletonAnimation()
            
            if let imageUrl = URL(string: self.popularContentViewModel.image) {
                self.popularContentImageView.setImage(withUrl: imageUrl, placeholderImage: nil) {
                    self.popularContentImageView.hideSkeleton()
                    self.layoutSubviews()
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.showSkeletonAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 0.4
        [self, self.popularContentImageView].forEach { (view) in
            view?.layer.cornerRadius = view!.bounds.width / 15
        }
        self.popularContentImageView.layoutSkeletonIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.layoutSubviews()
        self.showSkeletonAnimation()
    }
    
    func showSkeletonAnimation() -> Void {
        let gradient = SkeletonGradient(baseColor: UIColor("#EFEFEF") ?? .gray)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 1)
        self.isUserInteractionEnabled = false
        [self.popularContentImageView].forEach { (view) in
            view?.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        }
    }
    
    func hideSkeletonAnimation() -> Void {
        self.isUserInteractionEnabled = true
    }
    
}
