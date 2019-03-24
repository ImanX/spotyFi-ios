//
//  UIPlayerViewController.swift
//  SpotyFi
//
//  Created by ImanX on 3/23/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit
import FRadioPlayer
import AVFoundation
class UIPlayerViewController: UIBaseViewController{
   

    private var music:Music?;
    @IBOutlet weak var playerKit: UIPlayerKit!
    @IBOutlet weak var bgCover: UIImageView!
    @IBOutlet weak var playerController: UIPlayerControlKit!


    
    
    @discardableResult
    public class func start(music:Music?) -> UIPlayerViewController{
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(type: UIPlayerViewController.self);
        vc.music = music;
        if let navigationViewController = UIApplication.topViewController as? UINavigationController{
            navigationViewController.pushViewController(vc, animated: true);
        }
        
        return vc;
       
    }

  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }
       
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        
        if let title = music?.metadata?.name{
            self.navigationItem.title = title;
        }
        
        guard let url = URL(string: (music?.downloadURL)!) else {
            return;
        }
        
        
        PLAYER = AVPlayer(url: url);
        PLAYER.play();
        
        
        playerKit.imgArtwork.loadImage(url: (music?.metadata?.image?.first)!);
        playerKit.lblArtist.text = music?.metadata?.artists?.first?.name;
        playerKit.lblSongName.text = music?.metadata?.name;
        
        bgCover.loadImage(url: (music?.metadata?.image?.first)!)
        bgCover.makeBlur();
        
        
        PLAYER.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)

        
        playerController.compeletionPlayOrPause = {
            if PLAYER.isPlaying{
                PLAYER.pause();
                self.playerController.changeState(state: .Play);
            }else{
               PLAYER.play();
                self.playerController.changeState(state: .Pause);
            }
        }
        
    }
    
    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
        
        switch state {
        case .loading:
            appearLoading();
        case .loadingFinished:
           disappearLoading();
           playerController.changeState(state: .Pause);
        default: break
            
        }
        
    }
    
    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
        
    }
    
    
    
    func updateTimelineSong() {
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath != "status" {
            return;
        }
        
        
        
    }
}


