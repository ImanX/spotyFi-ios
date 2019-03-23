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
   

    private var music:Music?;
    
    public class func start(music:Music){
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(type: UIPlayerViewController.self);
        vc.music = music;
        if let navigationViewController = UIApplication.topViewController as? UINavigationController{
            navigationViewController.pushViewController(vc, animated: true);
        }
       
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }
       
    
    override func viewDidLoad() {
        super.viewDidLoad();
        player.delegate = self;
        
        
        if let title = music?.metadata?.name{
            self.navigationItem.title = title;
        }
        
        guard let url = URL(string: (music?.downloadURL)!) else {
            return;
        }
        
        player.radioURL = url;
        player.play();
        
    }
    
    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
        print(state.description);
    }
    
    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
        
    }
}


