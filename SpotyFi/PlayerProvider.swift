//
//  PlayerProvider.swift
//  SpotyFi
//
//  Created by ImanX on 3/24/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
 class PlayerProvider : NSObject{
    public static let shared = PlayerProvider();
    
    public var avPlayer:AVPlayer!;
    public var delegate:PlayerDelegate?;
    
    override init() {
        super.init();
        self.avPlayer = AVPlayer(playerItem: nil);
      
    }
    
    var isPlaying: Bool {
        return avPlayer.rate != 0 && avPlayer.error == nil
    }
    
    
    
    func makeNewPlay(url:URL) {
        self.avPlayer = AVPlayer(url: url);
        self.avPlayer.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)
//        self.avPlayer.addObserver(self, forKeyPath: "rate", options: NSKeyValueObservingOptions.new, context: nil)

        if let del = delegate {
            del.didLoading();
        }
    }
    
    func play() {
        self.avPlayer.play();
        if let del = delegate{
            del.didPlay();
        }
    }
    
    func pause(){
        self.avPlayer.pause();
        if let del = delegate{
            del.didPause();
        }
    }
    

    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard keyPath == "status" , let del = delegate else {
            return;
        }
        
        
        if (avPlayer.status == .unknown) || (avPlayer.status  == .failed){
            del.didFailureToPlay();
            return;
        }

        if(avPlayer.status == .readyToPlay){
            del.didReadyToPlay();
        }
        

    }
    
    
    
}



protocol PlayerDelegate {
    func didPlay();
    func didPause();
    func didStart();
    func didLoading();
    func didReadyToPlay();
    func didFailureToPlay();
}
