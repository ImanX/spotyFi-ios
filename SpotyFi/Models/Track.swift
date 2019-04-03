//
//  Playlist.swift
//  SpotyFi
//
//  Created by ImanX on 4/3/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Track: Model {
    
    init(json:JSON) {
        name = json["name"].string;
        explicit = json["explicit"].boolValue;
        album = Album(json: json["album"]);
        
        for item in json["artists"].arrayValue{
            artists.append(Artistx(json: item));
        }
    }
    
    public var artists:[Artistx] = [];
    public var explicit = false;
    public var name:String?;
    public var album:Album?;
}




