//
//  RESOURCE.swift
//  SpotyFi
//
//  Created by ImanX on 3/9/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation


public let SOCKET_URL = "wss://ws.coincap.io/prices?assets=bitcoin";
public let SOCKET_PORT:Int32 = 80;


public func xprint(cls:AnyClass?,any:Any){
    let className = (cls == nil) ? String() : String(describing: cls.self!)
    print("\(Bundle.appName) \(className): \(any)")
}

public func xprint(any:Any){
    xprint(cls: nil, any: any);
}


extension Bundle{
    public static var appName:String = Bundle.main.infoDictionary?["CFBundleName"] as! String;
}
