//
//  ViewController.swift
//  SpotyFi
//
//  Created by ImanX on 3/9/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit
import Starscream
import FRadioPlayer
import SwiftyJSON;
import ESTMusicIndicator
class ViewController: UIBaseViewController{

    
    
//    private func setupNowPlayingInfoCenter() {
//        UIApplication.shared.beginReceivingRemoteControlEvents();
//        MPRemoteCommandCenter.shared().playCommand.addTarget {event in
//          //  self.updateNowPlayingInfoCenter()
//            return .success
//        }
//        MPRemoteCommandCenter.shared().pauseCommand.addTarget {event in
//            return .success;
//        }
//        MPRemoteCommandCenter.shared().nextTrackCommand.addTarget {event in
//            return .success;
//
//        }
//        MPRemoteCommandCenter.shared().previousTrackCommand.addTarget {event in
//            return .success;
//
//        }
//    }
    
    @IBOutlet weak var edtURL: UITextField!
    
    

    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.returnKeyType == .search , (textField.text?.isSpotifyURL())! else{
            return super.textFieldShouldReturn(textField);
        }
        
        guard let url = URL(string: textField.text!) else {
            return super.textFieldShouldReturn(textField);
        }
        
        
    
        self.appearLoading();
        let request = RequestMusic(url: url.description);
        SOCKET.send(string: request.toJSON().description);
        
        return super.textFieldShouldReturn(textField);

    }
    

    

    

    
    override func viewDidLoad() {
        super.viewDidLoad();
    
        self.edtURL.delegate = self;
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        if PLAYER.isPlaying{
            let indicator = ESTMusicIndicatorView.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 200, height: 200)));
           // indicator.sizeToFit();
            indicator.state = .playing;
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator);
            navigationItem.rightBarButtonItem?.customView!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openUIPlayerViewController)))

            
        }
        
    }
    
    override func didConnect() {
        super.didConnect();
       
    }
    
    @objc func openUIPlayerViewController() {
        UIPlayerViewController.represent();

    }

    override func didReceiveMessage(data: String) {
        let music = Music(data: data);
        self.disappearLoading();
        UIPlayerViewController.start(music: music);
        
    }
    

}

