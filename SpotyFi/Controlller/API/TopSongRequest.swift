//
//  TopSongRequest.swift
//  SpotyFi
//
//  Created by ImanX on 4/4/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class TopSongRequest: Request<[Track]> {
     init(artistID:String) {
        let url = URL.encode(string: "\(REST_URL)/artistTopTracks?id=\(artistID)")
        super.init(url: url, method: "GET")
        completionParser = { (json) -> [Track] in
            var albums = [Track]();
            for item in json.arrayValue{
                albums.append(Track(json: item));
            }
            return albums;
        }
        
    }
}
