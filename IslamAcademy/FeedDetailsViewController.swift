//
//  FeedDetailsViewController.swift
//  IslamAcademy
//
//  Created by Hosam Elsafty on 9/30/18.
//  Copyright © 2018 Hosam Elsafty. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

import MobilePlayer


class FeedDetailsViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var head: UILabel!
    @IBOutlet weak var describe: UILabel!
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var text: UILabel!
    var feedModel : Feed?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let fModel = feedModel {
           bind(model: fModel)
        }
        if let videoUrl = feedModel?.videoLink {
            videoPrepare(url : videoUrl)
        }else if let lText = feedModel?.text{
            text.text = lText
            text.isHidden = false
        }
    }
    
    func videoPrepare(url : String) {
        guard let url = URL(string: url) else {
            return
        }
        
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        let player = AVPlayer(url: url)
        
        // Create a new AVPlayerViewController and pass it a reference to the player.
        let controller = AVPlayerViewController()
        controller.player = player
        player.play()
        //add as a childviewcontroller
        addChildViewController(controller)
        // Add the child's View as a subview
        controller.view.frame = container.frame
        container.addSubview(controller.view)
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        controller.didMove(toParentViewController: self)
        viewDidLayoutSubviews()
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
        head.text = model.title
        describe.text = model.describe
    }
}
