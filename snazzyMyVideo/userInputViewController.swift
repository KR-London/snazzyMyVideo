//
//  userInputViewController.swift
//  snazzyMyVideo
//
//  Created by Kate Roberts on 24/06/2020.
//  Copyright © 2020 SaLT for my Squid. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class userInputViewController: UIViewController {
    
    var playerViewController: AVPlayerViewController?
    var url = URL( string: "banana.MP4", relativeTo: Bundle.main.url(forResource: "banana", withExtension: "MP4"))!
    var player = AVPlayer()
    let editor = VideoEditor()
    
    lazy var addSoundButton: UIButton = {
        let button = UIButton()
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "tv.music.note"), for: .normal)
        } else {
            button.setTitle("Music", for: .normal)
        }
       // button.addTarget(self, action: #selector(loadAudio), for: .touchUpInside)
        return button
    }()
    
    lazy var addMagicButton: UIButton = {
        let button = UIButton()
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "wand.and.stars"), for: .normal)
        } else {
            button.setTitle("Magic", for: .normal)
        }
       button.addTarget(self, action: #selector(addMagic), for: .touchUpInside)
        return button
    }()
    
    lazy var finishedButton: UIButton = {
        let button = UIButton()
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(systemName: "checkmark.seal"), for: .normal)
        } else {
            button.setTitle("Done", for: .normal)
        }
        //button.alpha = 0.2
      //  button.addTarget(self, action: #selector(save), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        playerViewController = AVPlayerViewController()
        //    playerViewController!.view.frame = containerView.frame
        
        self.addChild(playerViewController!)
        
        
        layoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        player = AVPlayer(url:url)
        playerViewController!.player = player
        player.play()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player.currentItem, queue: .main) { [weak self] _ in
            self?.player.seek(to: CMTime.zero)
            self?.player.play()
        }
    }
    
    @objc func addMagic(){
        self.editor.makeBirthdayCard(fromVideoAt: url, forName: "Cassie") { exportedURL in
            self.showCompleted()
        }
    }
    
    func showCompleted() {
        //  activityIndicator.stopAnimating()
        //  imageView.alpha = 1
        //  pickButton.isEnabled = true
        //    recordButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func layoutSubviews(){
        
        view.addSubview(playerViewController!.view)
        playerViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerViewController!.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerViewController!.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playerViewController!.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            playerViewController!.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])
        
        playerViewController!.view.contentMode = .scaleAspectFill
        playerViewController!.view.frame = CGRect (x:300, y:300, width:200, height:400)
        
        
        
        view.addSubview(addMagicButton)
        addMagicButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addMagicButton.trailingAnchor.constraint(equalTo: playerViewController!.view.trailingAnchor, constant: 20),
            addMagicButton.bottomAnchor.constraint(equalTo: playerViewController!.view.topAnchor, constant: -10),
            addMagicButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            addMagicButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)
        ])
        
        view.addSubview(addSoundButton)
        addSoundButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addSoundButton.leadingAnchor.constraint(equalTo: playerViewController!.view.leadingAnchor, constant: -20),
            addSoundButton.bottomAnchor.constraint(equalTo: playerViewController!.view.topAnchor, constant: -10),
            addSoundButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            addSoundButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)
        ])
        
        view.addSubview(finishedButton)
        finishedButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            finishedButton.trailingAnchor.constraint(equalTo: playerViewController!.view.trailingAnchor, constant: 20),
            finishedButton.topAnchor.constraint(equalTo: playerViewController!.view.bottomAnchor, constant: 10),
            finishedButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            finishedButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07)
        ])
    }
}
