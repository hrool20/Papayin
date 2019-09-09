//
//  SplashScreenViewController.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/9/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            UIView.animate(withDuration: 0.5,
            animations: {
                self.logoImageView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
            },
            completion: { (_) in
                UIView.animate(withDuration: 0.4, animations: {
                    self.logoImageView.backgroundColor = .white
                })
                
                UIView.animate(withDuration: 0.8,
                animations: {
                    self.logoImageView.bounds = CGRect(x: 0, y: 0, width: 2000, height: 2000)
                },
                completion: { (_) in
                    guard let snapshot = keyWindow.snapshotView(afterScreenUpdates: true) else {
                        return
                    }
                    mainViewController?.view.addSubview(snapshot)
                    keyWindow.rootViewController = mainViewController
                    
                    UIView.transition(with: snapshot,
                                      duration: 0.2,
                                      options: .transitionCrossDissolve,
                    animations: {
                        snapshot.layer.opacity = 0.0
                    },
                    completion: { (_) in
                        snapshot.removeFromSuperview()
                    })
                })
            })
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.logoImageView.layer.cornerRadius = self.logoImageView.bounds.height / 15
        self.logoImageView.image = self.logoImageView.image?.withRenderingMode(.alwaysTemplate)
        self.logoImageView.tintColor = .white
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
