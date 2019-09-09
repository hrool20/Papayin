//
//  CastCollectionViewCell.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import SkeletonView

class CastCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return "castViewCell"
    }
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    var castViewModel: CastViewModel! {
        didSet {
            guard self.castViewModel != nil else {
                return
            }
            
            self.hideSkeletonAnimation()
            
            if let imageUrl = URL(string: self.castViewModel.image) {
                self.castImageView.setImage(withUrl: imageUrl, placeholderImage: nil) {
                    self.castImageView.hideSkeleton()
                    self.layoutSubviews()
                }
            }
            self.castNameLabel.text = self.castViewModel.name
            self.characterLabel.text = self.castViewModel.character
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.showSkeletonAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.castImageView.layer.cornerRadius = self.castImageView.bounds.height / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.showSkeletonAnimation()
    }
    
    func showSkeletonAnimation() -> Void {
        let gradient = SkeletonGradient(baseColor: UIColor("#EFEFEF") ?? .gray)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 1)
        self.isUserInteractionEnabled = false
        [self.castNameLabel, self.characterLabel].forEach { (label) in
            label?.linesCornerRadius = 5
        }
        [self.castImageView, self.castNameLabel, self.characterLabel].forEach { (view) in
            view?.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        }
    }
    
    func hideSkeletonAnimation() -> Void {
        self.isUserInteractionEnabled = true
        [self.castNameLabel, self.characterLabel].forEach { (view) in
            view?.hideSkeleton()
        }
    }
    
}
