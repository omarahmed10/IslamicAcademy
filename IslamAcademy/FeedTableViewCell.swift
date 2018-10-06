//
//  FeedTableViewCell.swift
//  IslamAcademy
//
//  Created by Mohamed E. Fayed on 9/28/18.
//  Copyright © 2018 Hosam Elsafty. All rights reserved.
//

import UIKit

class Colors {
    var gl:CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 192.0 / 255.0, green: 38.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 35.0 / 255.0, green: 2.0 / 255.0, blue: 2.0 / 255.0, alpha: 1.0).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 0.5]
    }
}

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var describe: UILabel!
    @IBOutlet weak var container: GradientView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(model : Feed){
        switch model.type {
        case .Article:
            container.secondColor = UIColor.red
            container.firstColor = UIColor.white
        case .Audio:
            container.secondColor = UIColor.blue
            container.firstColor = UIColor.white
        case .Video:
            container.secondColor = UIColor.green
            container.firstColor = UIColor.white
        default:
            break
        }
        title.text = model.title
        describe.text = model.describe
    }
}
