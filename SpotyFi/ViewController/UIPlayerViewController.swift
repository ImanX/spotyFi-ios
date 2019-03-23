//
//  UIPlayerViewController.swift
//  SpotyFi
//
//  Created by ImanX on 3/23/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit
import FRadioPlayer
class UIPlayerViewController: UIBaseViewController , FRadioPlayerDelegate{
   

    private let player = FRadioPlayer.shared;
    private var music:Music?;
    
    public class func start(music:Music){
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(type: UIPlayerViewController.self);
        vc.music = music;
        UIApplication.topViewController?.present(vc, animated: true, completion: nil);
       
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        player.delegate = self;
      
        guard let url = URL(string: (music?.downloadURL)!) else {
            return;
        }
        
        player.radioURL = url;
        player.play();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        
    }
    
    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
        
    }
    
    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
        
    }
}


