//
//  VideoPlayerViewController.swift
//  brazitv2
//
//  Created by Sarosh Tahir on 03/06/2024.
//

import UIKit
import AVKit

class VideoPlayerViewController: UIViewController {
    var videoURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create an AVPlayer with the video URL
        let player = AVPlayer(url: videoURL)
        
        // Create an AVPlayerViewController and set the player
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        // Add the playerViewController as a child view controller
        addChild(playerViewController)
        view.addSubview(playerViewController.view)
        
        // Use Auto Layout to make playerViewController's view fill the parent view
        playerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            playerViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Notify the playerViewController that it has been moved to the parent
        playerViewController.didMove(toParent: self)
        
        // Start playing the video
        player.play()
    }
}
