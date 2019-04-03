//
//  Artist.swift
//  SpotyFi
//
//  Created by ImanX on 4/3/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Artistx: Model {
    public var name:String?;
    public var id:String?;
    public var uri:String?;
    public var href:String?;
    public var externalURL:String?;
    public var popularity:Int32?;
    public var geners:[String] = [];
    public var followers:Int32?;
    public var pictures:[Picture] = [];
    
    public var gener:String{
        var value = "";
        geners.forEach { (val) in
            value.append(val);
            value.append(" ");
        }
        
        return value;
    }
    
    init(json:JSON) {
        name = json["name"].string;
        id = json["id"].string;
        uri = json["uri"].string;
        href = json["href"].string;
        externalURL = json["external_urls"]["spotify"].string;
        followers = json["Followers"]["total"].int32;
        popularity = json["popularity"].int32;
        
        for item in json["genres"].arrayValue{
            geners.append(item.stringValue);
        }
     
        for item in json["images"].arrayValue{
            let picutre = Picture();
            picutre.URL = item["url"].string
            pictures.append(picutre);
        }
    }
}
