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
import NFDownloadButton
import Digger
import XLActionController
import Bottomsheet
import NotificationBannerSwift
class UIPlayerViewController: UIBaseViewController{
    
    
    
    
    private static var downloadBanner:NotificationBanner?;
    internal var currentMusic:Music?;
    private var delegate:IPlayerDelegate!;
    
    
    @IBOutlet weak var playerKit: UIPlayerKit!
    @IBOutlet weak var bgCover: UIImageView!
    @IBOutlet weak var playerController: UIPlayerControlKit!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lblFullTime: UILabel!
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblCopyrights: UILabel!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated);
        PLAYER_VIEWCONTROLLER = self;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        PLAYER.delegate = self;
        

        playerController.compeletionPlayOrPause = {
            if PLAYER.isPlaying{
                PLAYER.pause();
                self.playerController.changeState(state: .Play);
                
            }else{
                PLAYER.play();
                self.playerController.changeState(state: .Pause);
            }
        }
        
        playerController.compeletionPervious = {
            self.delegate.didPerviousClick();
            self.makeToPlayMusic(music: self.delegate.getCurrentMusic());
        }
        
        playerController.compeletionForward = {
            self.delegate.didForwardClick();
            self.makeToPlayMusic(music: self.delegate.getCurrentMusic());

        }
        
        
        
        
        delegate.viewDidCreate(viewController: self);
        makeToPlayMusic(music: delegate.getCurrentMusic())
        
        
        
    }
    
    
    
    func makeToPlayMusic(music:Music) {
        
        self.slider.value = 0.0;
        self.currentMusic = music;
        
        
        guard let url = URL(string: (music.downloadURL)!) else {
            return;
        }
        
        
        
        if let song = music.metadata?.name{
            playerKit.lblSongName.text = song;
            
        }
        
        
        if let artwork = music.metadata?.image?.first{
            playerKit.imgArtwork.loadImage(url: artwork);
            bgCover.loadImage(url: artwork);
            bgCover.makeBlur();
        }else if let artwork = music.metadata?.photo {
            playerKit.imgArtwork.image = artwork;
            bgCover.image = artwork;
            bgCover.makeBlur();
        }
        
        if let artist = music.metadata?.artists?.first?.name{
            playerKit.lblArtist.text = artist;
        }
        
        if let copyright = music.metadata?.copyright{
            lblCopyrights.text = copyright;
        }
        
        
        let seekColor = playerKit.imgArtwork.getPixelColor(pos: CGPoint(x: 10, y: 10));
        self.slider.minimumTrackTintColor = seekColor;        
        PLAYER.makeNewPlay(url: url);
        PLAYER.play();
        
        delegate.readyToPlay(music: music);
        
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
    
   
    
    
}




extension UIPlayerViewController {
    
    
    
    
    @discardableResult
    public class func start(delegate:IPlayerDelegate) -> UIPlayerViewController{
        
        
       
        if PLAYER_VIEWCONTROLLER != nil , PLAYER_VIEWCONTROLLER.currentMusic?.downloadURL == delegate.getCurrentMusic().downloadURL{
            represent();
            return PLAYER_VIEWCONTROLLER;
        }
        
        
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(type: UIPlayerViewController.self);
        vc.delegate = delegate;
        if let navigationViewController = UIApplication.topViewController as? UINavigationController{
            navigationViewController.pushViewController(vc, animated: true);
        }
        return vc;
        
    }
    
    public class func represent(){
        guard let parentVC  = UIApplication.topViewController as? UINavigationController else{
            return;
        }
        
        guard let playerVC = PLAYER_VIEWCONTROLLER else{
            return;
        }
        
        parentVC.pushViewController(playerVC, animated: true);
    }
    
}




//MARK: Download.
extension UIPlayerViewController{
    internal func download(){
        //        if (isDownloadedFile){
        //            return;
        //        }
        //
        
        
        
        guard let safeNull = currentMusic?.downloadURL, let url = URL(string: safeNull)  else {
            return;
        }
        

        let banner = UIDownloadBanner(frame: CGRect(x: 0, y: 0, width: 100, height: 30));
    
        banner.lblTitle.text = self.currentMusic?.metadata?.name;
        UIPlayerViewController.downloadBanner = NotificationBanner(customView: banner);
        UIPlayerViewController.downloadBanner?.autoDismiss = false;
        UIPlayerViewController.downloadBanner?.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: self);
        
        Downloader().enqueue(url: url) { (percents, url, error) in
            if (url != nil){
                let result = PathManager.shared.writeFile(at: url!, name: (self.currentMusic?.metadata?.name)!)
                self.currentMusic?.downloadURL = result.1?.absoluteString;
                UIPlayerViewController.downloadBanner?.dismiss();
                return;
            }
            
            if (error != nil){
                UIPlayerViewController.downloadBanner?.dismiss();
                print(error!);
                return;
            }
            
            
            if (percents != nil){
                print(percents);
                //  self.btnDownload.downloadPercent = CGFloat(percents!);
            }
            
        }
    }
    
}

extension UIPlayerViewController : PlayerDelegate{
    
    func didFinish() {
        
    }
    
    func didStart() {
        
    }
    
    func didPlay() {
        
    }
    
    func didPause() {
        
    }
    
    func didLoading() {
    }
    
    func didReadyToPlay() {
        disappearLoading();
        let duration = PLAYER.avPlayer.currentItem?.asset.duration
        let seconds = CMTimeGetSeconds(duration!);
        self.slider.maximumValue = Float(seconds);
        self.playerController.changeState(state: .Pause);
        
        let fullSecond = Int(seconds);
        self.lblFullTime.text = NSString(format: "%2d:%02d", fullSecond/60, fullSecond%60) as String;
        
        
        PLAYER.avPlayer.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: .main) { (timr) in
            let time = CMTimeGetSeconds(PLAYER.avPlayer.currentTime());
            self.slider!.value = Float ( time );
            
            let leftSecond = Int(time)
            self.lblCurrentTime.text = NSString(format: "%2d:%02d", leftSecond/60, leftSecond%60) as String;
        }
        
    }
    
    
    func didFailureToPlay() {
        disappearLoading();
    }
    
}

extension UIPlayerViewController{
    @IBAction func openAction() {
        
        let song = currentMusic?.metadata?.name;
        let artist = currentMusic?.metadata?.artists?.first?.name;
        let actionController = SpotifyActionController()
        actionController.headerData = SpotifyHeaderData(title:song! ,
                                                        subtitle: artist!,
                                                        image: playerKit.imgArtwork.image!);
        let downloadAction = Action(ActionData(title: "Download", image: #imageLiteral(resourceName: "download")), style: .default) { (action) in
            self.download();
        }
        
        let shareAction = Action(ActionData(title: "Share", image: #imageLiteral(resourceName: "sharer")), style: .default) { (action) in
            let url = URL(string: (self.currentMusic?.downloadURL)!);
            let a = UIActivityViewController(activityItems: [url], applicationActivities: nil);
            
            self.present(a,
                         animated: true,
                         completion: nil)
        }
        
        if !(currentMusic?.metadata?.isLocal)!{
            actionController.addAction(downloadAction);
        }else{
            actionController.addAction(shareAction);
        }
        present(actionController, animated: true, completion: nil);
    }
    
}


