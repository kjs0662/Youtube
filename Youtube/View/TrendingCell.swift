//
//  TrendingCell.swift
//  Youtube
//
//  Created by 김진선 on 2017. 12. 27..
//  Copyright © 2017년 JinseonKim. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
