//
//  BaseViewController.swift
//  SpotyFi
//
//  Created by ImanX on 3/9/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import UIKit
import NotificationBannerSwift
import AVFoundation;

class UIBaseViewController: UIViewController ,SocketerDelegate{
    
    private var banner = Banner();
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
    
    
    
    func didWiat() {
        DispatchQueue.main.async {
            self.banner.show(title: "Connecting...");
        }
        
    }
    
    func didConnect() {
        DispatchQueue.main.async {
            self.banner.reloadLabel(title: "Connected");
            self.banner.dismiss(delay: 2);
        }
    }
    
    func didDisconnect() {
        DispatchQueue.main.async {
            self.banner.reloadLabel(title: "Disconnected");
        }
        disappearLoading();
    }
    
    func didReceiveMessage(data: String) {
        
    }
    
    func didException(error: Error?) {
        print(error?.localizedDescription);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.view.backgroundColor = .black;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (SOCKET == nil) || (!SOCKET.isConnected)  {
            SOCKET = Socketer(delegate: self);
            SOCKET.connect();
        }
    }
    
    func performGradiant(color:UIColor,animate:Bool = true){
        
        self.view.makeGradiant(top: color);
        if animate {
            self.view.alpha = 0.0;
            UIView.animate(withDuration: 0.6, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.view.alpha = 1.0;
            }, completion: { (bool) in
                
            })
        }

        
    }
    
}
