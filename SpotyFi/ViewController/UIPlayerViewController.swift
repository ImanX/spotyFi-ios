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
class UIPlayerViewController: UIBaseViewController, PlayerDelegate{
    
    
    func didStart() {

    }
    
    func didPlay() {
        
    }
    
    func didPause() {
        
    }
    
    func didLoading() {
        appearLoading();
    }
    
    func didReadyToPlay() {
        disappearLoading();
        let duration = PLAYER.avPlayer.currentItem?.asset.duration
        let seconds = CMTimeGetSeconds(duration!);
        self.slider.maximumValue = Float(seconds);
        self.playerController.changeState(state: .Pause);

        let fullSecond = Int(seconds);
        self.lblFullTime.text = NSString(format: "%2d:%02d", fullSecond/60, fullSecond%60) as String;



    }
    
    func didFailureToPlay() {
        disappearLoading();
        
    }
    
    
    
    private var music:Music?;
    @IBOutlet weak var playerKit: UIPlayerKit!
    @IBOutlet weak var bgCover: UIImageView!
    @IBOutlet weak var playerController: UIPlayerControlKit!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lblFullTime: UILabel!
    @IBOutlet weak var lblCurrentTime: UILabel!
    
    
    
    
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
        
        
        guard let url = URL(string: (music?.downloadURL)!) else {
            return;
        }
        
        if let artwork = music?.metadata?.image?.first{
            playerKit.imgArtwork.loadImage(url: artwork);
            bgCover.loadImage(url: artwork);
            bgCover.makeBlur();
        }
        
        if let artist = music?.metadata?.artists?.first?.name{
            playerKit.lblArtist.text = artist;
        }
        
        if let song = music?.metadata?.name{
            playerKit.lblSongName.text = song;

        }
        
        PLAYER.delegate = self;
        PLAYER.makeNewPlay(url: url);
        PLAYER.play();
        
        
        

        playerController.compeletionPlayOrPause = {
            if PLAYER.isPlaying{
                PLAYER.pause();
                self.playerController.changeState(state: .Play);
            }else{
                PLAYER.play();
                self.playerController.changeState(state: .Pause);
            }
        }
        
    
        
        
        PLAYER.avPlayer.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: .main) { (timr) in
            let time = CMTimeGetSeconds(PLAYER.avPlayer.currentTime());
            self.slider!.value = Float ( time );
            
            let leftSecond = Int(time)
            self.lblCurrentTime.text = NSString(format: "%2d:%02d", leftSecond/60, leftSecond%60) as String;
        }
        
    }
    
    @IBAction func changeSeekTime(_ sender: Any) {
        let seconds = Int64(slider.value)
        let targetTime  = CMTimeMake(value: seconds, timescale: 1)

        PLAYER.avPlayer!.seek(to: targetTime)
        
        if PLAYER.avPlayer!.rate == 0
        {
            PLAYER.play()
        }
    }
    
    func updateTimelineSong() {
        
    }
}


