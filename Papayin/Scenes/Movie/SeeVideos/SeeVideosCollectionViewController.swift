//
//  SeeVideosCollectionViewController.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/9/19.
//  Copyright © 2019 Example. All rights reserved.
//

import UIKit

class SeeVideosCollectionViewController: UICollectionViewController {

    @IBOutlet var emptyView: UIView!
    @IBOutlet weak var emptyLabel: UILabel!
    private var seeVideosViewModels: [SeeVideosViewModel]!
    private var isLoadedFromFirstTime: Bool!
    var cellWidth: CGFloat!
    var movieId: Int? {
        didSet {
            guard self.movieId != nil else {
                return
            }
            
            self.getMovieVideos {
                self.isLoadedFromFirstTime = false
            }
        }
    }
    var tvShowId: Int? {
        didSet {
            guard self.tvShowId != nil else {
                return
            }
            
            self.getTVShowVideos {
                self.isLoadedFromFirstTime = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.seeVideosViewModels = []
        self.isLoadedFromFirstTime = true
    }
    
    func getMovieVideos(_ completion: (() -> Void)? = nil) -> Void {
        MovieService.shared.getMovieVideos(movieId: self.movieId!,
        successCompletion: { (videos) in
            self.seeVideosViewModels = videos.map({ (video) -> SeeVideosViewModel in
                return SeeVideosViewModel(video: video)
            })
            completion?()
            self.collectionView?.reloadData()
        }) { (error) in
            // MARK: Make an action
        }
    }
    
    func getTVShowVideos(_ completion: (() -> Void)? = nil) -> Void {
        TVShowService.shared.getTVShowVideos(tvShowId: self.tvShowId!,
        successCompletion: { (videos) in
            self.seeVideosViewModels = videos.map({ (video) -> SeeVideosViewModel in
                return SeeVideosViewModel(video: video)
            })
            completion?()
            self.collectionView?.reloadData()
        }) { (error) in
            // MARK: Make an action
        }
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
        return (self.seeVideosViewModels.isEmpty && !self.isLoadedFromFirstTime) ? 0 : 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (!self.isLoadedFromFirstTime) ? self.seeVideosViewModels.count : 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeeVideosCollectionViewCell.reuseIdentifier, for: indexPath) as? SeeVideosCollectionViewCell {
            guard !self.seeVideosViewModels.isEmpty else {
                return cell
            }
            cell.seeVideosViewModel = self.seeVideosViewModels[indexPath.row]
            cell.delegate = self
            
            return cell
        }
        
        return UICollectionViewCell()
    }

}
extension SeeVideosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let width = self.cellWidth - 20
        
        return CGSize(width: width, height: flowLayout.itemSize.height)
    }
}
extension SeeVideosCollectionViewController: SeeVideosCollectionViewCellDelegate {
    func playVideo(videoUrl: String) {
        if let youtubeUrl = URL(string: videoUrl) {
            UIApplication.shared.open(youtubeUrl, options: [:], completionHandler: nil)
        }
    }
}
