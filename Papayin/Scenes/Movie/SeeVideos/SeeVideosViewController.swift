//
//  SeeVideosViewController.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/8/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class SeeVideosViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var videosContainerView: UIView!
    var movieId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.backgroundView.alpha = 0.7
        
        if let videoViewController = self.childViewControllers.first as? SeeVideosCollectionViewController {
            videoViewController.cellWidth = UIScreen.main.bounds.width - 80
            videoViewController.movieId = self.movieId
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.videosContainerView.layer.cornerRadius = self.videosContainerView.bounds.width / 25
    }
    
    @IBAction func didClosePopup(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
