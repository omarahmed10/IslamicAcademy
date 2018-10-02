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


class FeedDetailsViewController: UIViewController,AVAudioPlayerDelegate {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var head: UILabel!
    @IBOutlet weak var describe: UILabel!
    
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var audioView: UIView!
    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var audioProgressBar: UIProgressView!
    @IBOutlet weak var text: UILabel!
    
    var feedModel : Feed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let fModel = feedModel {
           bind(model: fModel)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let videoUrl = feedModel?.videoLink {
            audioView.removeFromSuperview()
            textView.removeFromSuperview()
            videoPrepare(url : videoUrl)
        }else if let lText = feedModel?.text{
            videoView.removeFromSuperview()
            audioView.removeFromSuperview()
            text.text = lText
        }else if let _ = feedModel?.audioLink {
            textView.removeFromSuperview()
            videoView.removeFromSuperview()
            prepareAudio()
        }
    }
    
    var videoPlayer : AVPlayer! = nil
    var videoController : AVPlayerViewController! = nil
    
    func videoPrepare(url : String) {
        guard let url = URL(string: url) else {
            return
        }
        
        // Create an AVPlayer, passing it the HTTP Live Streaming URL.
        videoPlayer = AVPlayer(url: url)
        
        // Create a new AVPlayerViewController and pass it a reference to the player.
        videoController = AVPlayerViewController()
        videoController.player = videoPlayer
        videoPlayer.play()
        //add as a childviewcontroller
        addChildViewController(videoController)
        // Add the child's View as a subview
        videoController.view.frame = videoView.frame
        videoView.insertSubview(videoController.view, at: 0)
        videoController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        videoController.didMove(toParentViewController: self)
        viewDidLayoutSubviews()
    }
    
    var audioPlayer:AVPlayer?
    var playerItem:AVPlayerItem?
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var playbackSlider: UISlider!
    var audioTimer: Timer!

    func prepareAudio (){
        guard let link = feedModel?.audioLink else {return}
        let url = URL(string: link)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        audioPlayer = AVPlayer(playerItem: playerItem)
        
        let playerLayer=AVPlayerLayer(player: audioPlayer!)
        playerLayer.frame=CGRect(x:0, y:0, width:10, height:50)
        self.audioView.layer.addSublayer(playerLayer)

        // Add playback slider
        playbackSlider.minimumValue = 0
        
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        audioTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateAudioProgressView), userInfo: nil, repeats: true)
        playbackSlider.maximumValue = Float(seconds)
        playbackSlider.isContinuous = true
        playbackSlider.addTarget(self, action: #selector(playbackSliderValueChanged(_:)), for: .valueChanged)
        // playbackSlider.addTarget(self, action: "playbackSliderValueChanged:", forControlEvents: .ValueChanged)
        self.audioView.insertSubview(playbackSlider, at: 0)
    }
    
    @objc func updateAudioProgressView() {
        guard let player = audioPlayer else {
            return
        }
        let float = Float(CMTimeGetSeconds(player.currentTime()))
        playbackSlider.setValue(float, animated: false)
    }
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider)
    {
        
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(seconds, 1)
        
        audioPlayer!.seek(to: targetTime)
        
        if audioPlayer!.rate == 0
        {
            audioPlayer?.play()
        }
    }
    
    
    @IBAction func playButtonTapped(_ sender:UIButton)
    {
        if audioPlayer?.rate == 0
        {
            audioPlayer!.play()
            //playButton!.setImage(UIImage(named: "player_control_pause_50px.png"), forState: UIControlState.Normal)
            playButton!.setImage(#imageLiteral(resourceName: "icons8-pause-30"), for: .normal)
        } else {
            audioPlayer!.pause()
            //playButton!.setImage(UIImage(named: "player_control_play_50px.png"), forState: UIControlState.Normal)
            playButton!.setImage(#imageLiteral(resourceName: "icons8-play-32"), for: .normal)
        }
    }
    
//    var updater : CADisplayLink! = nil
//
//    var audioPlayer : AVAudioPlayer! = nil
//    var isPlaying = false
//
//    @IBAction func toggleAudioState(_ sender: UIButton) {
//        isPlaying = !isPlaying
//        sender.setImage(isPlaying ? #imageLiteral(resourceName: "icons8-play-32") : #imageLiteral(resourceName: "icons8-pause-30"), for: .normal)
//        if let link = feedModel?.audioLink, let url = URL(string: link) ,!isPlaying {
//            downloadFileFromURL(url)
//        } else {
//            audioPlayer?.stop()
//        }
//    }
//    func downloadFileFromURL(_ url:URL){
//        var downloadTask:URLSessionDownloadTask
//        downloadTask = URLSession.shared.downloadTask(with: url, completionHandler: { [weak self](URL, response, error) -> Void in
//            self?.play(URL!)
//        })
//        downloadTask.resume()
//    }
//
//    func play (_ url : URL){
//        do{
//            try self.audioPlayer = AVAudioPlayer(contentsOf: url)
//            self.audioPlayer.numberOfLoops = -1 // play indefinitely
//            self.audioPlayer.prepareToPlay()
//            self.audioPlayer.delegate = self
//            self.audioPlayer.play()
//            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateAudioProgressView), userInfo: nil, repeats: true)
//            DispatchQueue.main.async {
//                let f = Float(self.audioPlayer.currentTime/self.audioPlayer.duration)
//                print(f)
//                self.audioProgressBar.setProgress(f, animated: false)
//            }
//        }catch let error {
//            print(error)
//        }
//    }
//
//
//
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        audioTimer?.invalidate()
        videoPlayer?.pause()
        videoController?.view.removeFromSuperview()
        videoController = nil
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
