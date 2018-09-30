//
//  File.swift
//  IslamAcademy
//
//  Created by Mohamed E. Fayed on 9/28/18.
//  Copyright © 2018 Hosam Elsafty. All rights reserved.
//

import Foundation
import Firebase

enum FeedType : String {
    case Video = "المحاضرات"
    case Audio = "الصوتيات"
    case Article = "المقالات"
    case Main = "الرئيسية"
}

class Feed: NSObject {
    var type : FeedType = .Article
    var audioLink : String?
    var videoLink : String?
    var text : String?
    var title = ""
    var describe = ""
    
    override init() {
        
    }
    
    init?(dict: [String:String]) {
        guard let desc = dict["desc"]  as? String else { return nil }
        guard let title = dict["title"]  as? String else { return nil }
        guard let body = dict["content"]  as? String else { return nil }
        guard let type = dict["type"] as? String else {return nil}
        
        if type == "Lecture"{
            self.type = .Video
            self.videoLink = body
        }else if type == "Record"{
            self.type = .Audio
            self.audioLink = body
        }else if type == "Article"{
            self.type = .Article
            self.text = body
        }
        self.title = title
        self.describe = desc
        
    }
    
}
