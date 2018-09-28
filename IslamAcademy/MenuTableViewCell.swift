//
//  MenuTableViewCell.swift
//  IslamAcademy
//
//  Created by Hosam Elsafty on 9/27/18.
//  Copyright © 2018 Hosam Elsafty. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(model : FeedType){
        switch model {
        case .Article:
            logo.image = #imageLiteral(resourceName: "icons8-news-50")
        case .Audio:
            logo.image = #imageLiteral(resourceName: "icons8-music-50")
        case .Video:
            logo.image = #imageLiteral(resourceName: "icons8-documentary-50")
        case .Main:
            logo.image = #imageLiteral(resourceName: "icons8-home-50")
        }
        title.text = model.rawValue
    }

}
