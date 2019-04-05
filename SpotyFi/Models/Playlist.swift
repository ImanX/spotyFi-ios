//
//  Playlist.swift
//  SpotyFi
//
//  Created by ImanX on 4/4/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Playlist: Model {
    public var collaborative = false;
    public var extenalURL:String?;
    public var id:String?;
    public var pictures:[Picture] = [];
    public var name:String?;
    public var countOfTracks:Int?;
    
    init(json:JSON) {
        collaborative = json["collaborative"].boolValue;
        extenalURL = json["external_urls"]["spotify"].string;
        id = json["id"].string;
        name = json["name"].string;
        countOfTracks = json["tracks"]["total"].int;
        
        for item in json["images"].arrayValue{
            let pic = Picture();
            pic.URL = item["url"].string;
            pictures.append(pic);
        }
        
        
    }
    
}


