//
//  Socket.swift
//  SpotyFi
//
//  Created by ImanX on 3/9/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import Starscream

class Socketer: WebSocket , WebSocketDelegate {
    
    private var socketDelegate:SocketerDelegate!;
    private var timeoutInterval:TimeInterval = 5;
    
    
    func websocketDidConnect(socket: WebSocketClient) {
        socketDelegate.didConnect();
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        socketDelegate.didDisconnect();
        
        if let safeError = error {
            socketDelegate.didException(error: safeError);
        }
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        socketDelegate.didReceiveMessage(data: text);
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        
    }
    
    
    init(address:String = SOCKET_URL , delegate:SocketerDelegate) {
        var urlRequest = URLRequest(url: URL(string: address)!);
        urlRequest.timeoutInterval = timeoutInterval;
        super.init(request: urlRequest, protocols: nil, stream: FoundationStream());
        self.delegate = self;
        self.socketDelegate = delegate;
        self.socketDelegate.didWiat();
    }
    
    
    
    func send(string:String){
        super.write(string: string);
        xprint(cls: Socketer.self, any: "Send Data to \(string)")
    }
    
    override func connect() {
        super.connect()
        xprint(cls: Socketer.self, any: "connect")
    }
    
    func disconnect() {
        super.disconnect();
        xprint(cls: Socketer.self, any: "disconnect")
        
    }
    
    
    
}
