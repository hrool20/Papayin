//
//  SeasonCollectionViewController.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/9/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class SeasonCollectionViewController: UICollectionViewController {

    var seasonViewModels: [SeasonViewModel]! {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    private var isLoadedFromFirstTime: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.seasonViewModels = []
        self.isLoadedFromFirstTime = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (!self.seasonViewModels.isEmpty && !self.isLoadedFromFirstTime) ? self.seasonViewModels.count : 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonCollectionViewCell.reuseIdentifier, for: indexPath) as? SeasonCollectionViewCell {
            guard !self.seasonViewModels.isEmpty else {
                return cell
            }
            cell.seasonViewModel = self.seasonViewModels[indexPath.row]
            
            return cell
        }
        
        return UICollectionViewCell()
    }

}
extension SeasonCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        
        guard !self.seasonViewModels.isEmpty else {
            return flowLayout.itemSize
        }
        
        let seasonViewModel = self.seasonViewModels[indexPath.row]
        let approximateWidthOfLabel = flowLayout.itemSize.width - 110 - 10
        let size = CGSize(width: approximateWidthOfLabel, height: 1000)
        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)
        ]
        let estimatedFrame = NSString(string: seasonViewModel.overview).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        let height = estimatedFrame.height + 80 + 10
        
        if height < 150 {
            return flowLayout.itemSize
        } else {
            switch self.parent {
            case let vc as TVShowDetailViewController:
                print(vc.seasonContainerViewHeight.constant)
                vc.seasonContainerViewHeight.constant = (vc.seasonContainerViewHeight.constant < height + 10) ? height + 10 : vc.seasonContainerViewHeight.constant
                print(vc.seasonContainerViewHeight.constant)
            default:
                break
            }
            
            return CGSize(width: flowLayout.itemSize.width, height: height)
        }
    }
}
