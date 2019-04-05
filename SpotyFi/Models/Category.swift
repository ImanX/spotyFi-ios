//
//  Category.swift
//  SpotyFi
//
//  Created by ImanX on 4/4/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Category: Model {
    public var id:String?;
    public var name:String?;
    public var pictures:[Picture] = [];
    public var playlists:[Playlist]?;
    
    init(json:JSON) {
        id = json["id"].string;
        name = json["name"].string;
        for item in json["icons"].arrayValue{
            let pic = Picture();
            pic.URL = item["url"].string;
            pictures.append(pic);
        }
    }
    
}


