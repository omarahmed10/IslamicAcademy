//
//  File.swift
//  IslamAcademy
//
//  Created by Mohamed E. Fayed on 9/28/18.
//  Copyright © 2018 Hosam Elsafty. All rights reserved.
//

import Foundation

enum FeedType : String {
    case Video = "المحاضرات"
    case Audio = "الصوتيات"
    case Article = "المقالات"
    case Main = "الرئيسية"
}

class Feed {
    var type : FeedType = .Article
    var audioLink : String?
    var videoLink : String?
    var text : String?
    var title = ""
    var describe = ""
    init() {
        
    }
}
