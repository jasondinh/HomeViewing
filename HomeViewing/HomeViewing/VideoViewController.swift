//
//  VideoViewController.swift
//  HomeViewing
//
//  Created by Patrick Cho on 8/5/17.
//  Copyright © 2017 TinyWhale. All rights reserved.
//

import UIKit

import AVKit
import AVFoundation

class VideoViewController: UIViewController {
    
    var moviePlayer: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func playVideo() {
        guard let path = Bundle.main.path(forResource: "video", ofType:"MOV") else {
            debugPrint("video.MOV not found")
            return
        }
        let videoURL = URL(fileURLWithPath: path)
        moviePlayer = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: moviePlayer)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        moviePlayer?.play()
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])
    }

}
