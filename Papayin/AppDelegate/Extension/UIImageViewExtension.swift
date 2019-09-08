//
//  UIImageViewExtension.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {
    func setImage(withUrl url: URL, placeholderImage: UIImage?, completion: @escaping () -> Void) -> Void {
        self.af_setImage(withURL: url,
                         placeholderImage: placeholderImage,
                         filter: nil,
                         progress: nil,
                         progressQueue: DispatchQueue.main,
                         imageTransition: .noTransition,
                         runImageTransitionIfCached: false) { (_) in
                            completion()
        }
    }
}
