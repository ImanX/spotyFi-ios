//
//  Request.swift
//  SpotyFi
//
//  Created by ImanX on 4/2/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Request<M:Model>{
    
    
    
    init(url:URL , method:String) {
        self.url = url;
        self.method = method;
    }
    
    public var url:URL!
    public var method:String!
    public var completionParser:((JSON) -> M)!

}
