//
//  SockterDelegate.swift
//  SpotyFi
//
//  Created by ImanX on 3/10/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import Starscream
protocol SocketerDelegate {
    func didConnect();
    func didWiat();
    func didDisconnect();
    func didReceiveMessage(data:String);
    func didException(error:Error?);

    
    
}
