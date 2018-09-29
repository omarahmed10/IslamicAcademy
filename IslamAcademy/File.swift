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
    
    init() {
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String:Any] else { return nil }
        guard let desc = dict["desc"]  as? String else { return nil }
        guard let title = dict["title"]  as? String else { return nil }
        guard let body = dict["content"]  as? String else { return nil }
        guard let type = dict["type"] as? String else {return nil}
        
        self.title = title
        self.text = body
        
    }
    
}