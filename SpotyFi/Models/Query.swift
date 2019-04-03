//
//  Query.swift
//  SpotyFi
//
//  Created by ImanX on 4/3/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Query: Model {
    
    public var artists:[Artistx] = [];
    public var tracks:[Track] = [];
    public var albums:[Album] = [];
//    public var countOfResult:Int{
//        get{
//            var count = 0;
//            if artists.count > 0 {count=count+1};
//            if tracks.count > 0 {count=count+1};
//            if albums.count > 0 {count=count+1};
//            return count;
//        }
//    }
    
    init(json:JSON) {
        let artists = json["artists"]["items"].arrayValue;
        let albums = json["albums"]["items"].arrayValue;
        let tracks = json["tracks"]["items"].arrayValue;
        
        for item in artists{
            self.artists.append(Artistx(json: item));
        }

        
        for item in albums{
            self.albums.append(Album(json: item));
        }
        
        for item in tracks{
            self.tracks.append(Track(json: item));
        }

    }
}
