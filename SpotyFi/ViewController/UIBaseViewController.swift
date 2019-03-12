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

class UIBaseViewController: UIViewController ,SocketerDelegate{
    
    private var banner = Banner();
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
    
    public static var socket:Socketer!;
    
    
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
        
    }
    
    func didReceiveMessage(data: String) {
        
    }
    
    func didException(error: Error?) {
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIBaseViewController.socket == nil{
            UIBaseViewController.socket = Socketer(delegate: self);
            UIBaseViewController.socket.connect();
        }
    }
    
    
}
