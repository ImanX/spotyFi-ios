//
//  RequestMusic.swift
//  SpotyFi
//
//  Created by ImanX on 3/23/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class RequestMusic: Model {
    
    
    let uuid = UUID().uuidString;
    
    
    init(url:String) {
        super.init();
        json["body"] = [url];
        json["id"].string = uuid;
        json["type"] = "song";
    }
    
    
    
    override func toJSON() -> JSON {
        return json;
    }
}
