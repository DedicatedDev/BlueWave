//
//  testViewController.swift
//  BlueWave
//
//  Created by FreeBird on 4/22/20.
//  Copyright © 2020 SuccessResultSdnBhd. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

 var playerView = YoutubePlayerView(psEnabled: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(playerView)
        //playerView.fillSuperview()
        
        NSLayoutConstraint.activate([
        
            playerView.topAnchor.constraint(equalTo: view.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 100),
            playerView.heightAnchor.constraint(equalToConstant: 200)
        
        
        ])
     //   playerView.frame = CGRect(x: 0,y: 0,width: 200,height: 100)
        let playerVars: [String: Any] = [
            "controls": 1,
            "modestbranding": 1,
            "playsinline": 1,
            "origin": "https://youtube.com"
        ]
        playerView.delegate = self
        playerView.loadWithVideoId("x-MBR13sVqs", with: playerVars)
    }
}

extension ViewController: YoutubePlayerViewDelegate {
//    func playerViewDidBecomeReady(_ playerView: YoutubePlayerView) {
//        print("Ready")
//        playerView.fetchPlayerState { (state) in
//            print("Fetch Player State: \(state)")
//        }
//    }
//
//    func playerView(_ playerView: YoutubePlayerView, didChangedToState state: YoutubePlayerState) {
//        print("Changed to state: \(state)")
//    }
//    
//    func playerView(_ playerView: YoutubePlayerView, didChangeToQuality quality: YoutubePlaybackQuality) {
//        print("Changed to quality: \(quality)")
//    }
//
//    func playerView(_ playerView: YoutubePlayerView, receivedError error: Error) {
//        print("Error: \(error)")
//    }
//
//    func playerView(_ playerView: YoutubePlayerView, didPlayTime time: Float) {
//        print("Play time: \(time)")
//    }
//
//    func playerViewPreferredInitialLoadingView(_ playerView: YoutubePlayerView) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .red
//        return view
//    }
}
