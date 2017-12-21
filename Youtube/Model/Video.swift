//
//  Video.swift
//  Youtube
//
//  Created by 김진선 on 2017. 12. 20..
//  Copyright © 2017년 JinseonKim. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSData?
    
    var channel: Channel?
    
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
    
}
