//
//  RecordedAudio.swift
//  Pitch
//
//  Created by Alvin Landicho on 3/13/15.
//  Copyright (c) 2015 Alvin Landicho. All rights reserved.
//

import Foundation


class RecordedAudio: NSObject {
    
    var title: String!
    var filePathUrl: NSURL!
    
    init(title:String, filePathUrl: NSURL) {
        self.title = title
        self.filePathUrl = filePathUrl
    }
    
}

