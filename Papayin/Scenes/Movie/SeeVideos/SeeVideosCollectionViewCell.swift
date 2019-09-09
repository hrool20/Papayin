//
//  SeeVideosCollectionViewCell.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/9/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit
import SkeletonView

protocol SeeVideosCollectionViewCellDelegate: class {
    func playVideo(videoUrl: String) -> Void
}

class SeeVideosCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        return "videoViewCell"
    }
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    weak var delegate: SeeVideosCollectionViewCellDelegate?
    var seeVideosViewModel: SeeVideosViewModel! {
        didSet {
            guard self.seeVideosViewModel != nil else {
                return
            }
            
            self.hideSkeletonAnimation()
            
            if let thumbnailUrl = URL(string: self.seeVideosViewModel.thumbnailImage) {
                self.thumbnailImageView.setImage(withUrl: thumbnailUrl, placeholderImage: nil) {
                    self.thumbnailImageView.hideSkeleton()
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
        
        self.thumbnailImageView.layer.cornerRadius = self.thumbnailImageView.bounds.height / 20
        self.playButton.layer.cornerRadius = self.playButton.bounds.height / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.showSkeletonAnimation()
    }
    
    @IBAction func didPlayVideo(_ sender: UIButton) {
        self.delegate?.playVideo(videoUrl: self.seeVideosViewModel.videoUrl)
    }
    
    func showSkeletonAnimation() -> Void {
        let gradient = SkeletonGradient(baseColor: UIColor("#EFEFEF") ?? .gray)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 1)
        self.isUserInteractionEnabled = false
        [self.thumbnailImageView].forEach { (view) in
            view?.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        }
        [self.playButton].forEach { (view) in
            view?.isHidden = true
        }
    }
    
    func hideSkeletonAnimation() -> Void {
        self.isUserInteractionEnabled = true
        [self.playButton].forEach { (view) in
            view?.isHidden = false
        }
    }

}
