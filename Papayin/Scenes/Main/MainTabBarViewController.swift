//
//  MainTabBarViewController.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/7/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    @IBOutlet weak var mainTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setTabBarItems()
    }
    
    func setTabBarItems() -> Void {
        guard let homeTabBar = self.mainTabBar.items?[0],
            let movieTabBar = self.mainTabBar.items?[1],
            let tvShowTabBar = self.mainTabBar.items?[2] else {
                return
        }
        let size = CGSize(width: 30, height: 30)
        
        homeTabBar.title = "Home"
        homeTabBar.image = #imageLiteral(resourceName: "home_filled.png").resizeImage(targetSize: size)
        
        movieTabBar.title = "Movie"
        movieTabBar.image = #imageLiteral(resourceName: "clapperboard_filled.png").resizeImage(targetSize: size)
        
        tvShowTabBar.title = "TV Show"
        tvShowTabBar.image = #imageLiteral(resourceName: "tv_show_filled.png").resizeImage(targetSize: size)
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
