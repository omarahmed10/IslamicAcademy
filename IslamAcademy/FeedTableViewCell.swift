//
//  FeedTableViewCell.swift
//  IslamAcademy
//
//  Created by Mohamed E. Fayed on 9/28/18.
//  Copyright © 2018 Hosam Elsafty. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var describe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(model : Feed){
        switch model.type {
        case .Article:
            logo.image = #imageLiteral(resourceName: "icons8-news-50")
        case .Audio:
            logo.image = #imageLiteral(resourceName: "icons8-music-50")
        case .Video:
            logo.image = #imageLiteral(resourceName: "icons8-documentary-50")
        default:
            break
        }
        title.text = model.title
        describe.text = model.describe
    }
}
