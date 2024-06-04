//
//  ViewController.swift
//  brazitv2
//
//  Created by Sarosh Tahir on 03/06/2024.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    var playerViewController: AVPlayerViewController?
    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // URL of the initial video from the app bundle
        guard let initialVideoURL = Bundle.main.url(forResource: "BRAZI_APP", withExtension: "m4v") else {
            print("Could not find the initial video file in the bundle")
            return
        }
        
        // Initialize the player with the initial video URL
        player = AVPlayer(url: initialVideoURL)
        
        // Initialize the AVPlayerViewController
        playerViewController = AVPlayerViewController()
        
        // Set the player to the AVPlayerViewController
        playerViewController?.player = player
        
        // Disable playback controls
        playerViewController?.showsPlaybackControls = true
        
        if let playerView = playerViewController?.view {
            playerView.frame = self.view.bounds
            self.view.addSubview(playerView)
        }
        
        playerViewController?.videoGravity = .resizeAspectFill
        // Ensure the playerViewController is added to the hierarchy
        self.addChild(playerViewController!)
        playerViewController?.didMove(toParent: self)
        
        // Add an observer to detect when the initial video finishes playing
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(_:)), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        
        // Start playback
        player?.play()
    }
    
    @objc func playerItemDidReachEnd(_ notification: Notification) {
        // URL of the live stream
        guard let liveStreamURL = URL(string: "https://cbtvnow.com:5866/hls/livest2024.m3u8") else {
            print("Invalid URL for live stream")
            return
        }
        
        // Replace the current item with the live stream URL
        let liveStreamItem = AVPlayerItem(url: liveStreamURL)
        player?.replaceCurrentItem(with: liveStreamItem)
        
        // Start playback of the live stream
        player?.play()
    }
}
