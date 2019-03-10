//
//  BaseViewController.swift
//  SpotyFi
//
//  Created by ImanX on 3/9/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import UIKit
class UIBaseViewController: UIViewController ,SocketerDelegate{
    
    public static var socket:Socketer!;
    
    func didWiat() {
        
    }
    
    
    func didConnect() {
        
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
