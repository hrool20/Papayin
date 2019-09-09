//
//  SeeVideosViewModel.swift
//  Papayin
//
//  Created by Hugo Rosado on 9/9/19.
//  Copyright © 2019 Example. All rights reserved.
//

import Foundation

struct SeeVideosViewModel {
    let video: Video
    let thumbnailImage: String
    let videoUrl: String
    
    init(video: Video) {
        self.video = video
        self.thumbnailImage = "\(Constants.Url.thumbnailUrl)/\(video.key)/0.jpg"
        self.videoUrl = "https://www.youtube.com/watch?v=\(video.key)"
    }
}
