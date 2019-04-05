//
//  AlbumRequest.swift
//  SpotyFi
//
//  Created by ImanX on 4/4/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class AlbumRequest: Request<[Album]> {
    init(artistID:String){
        let url = URL.encode(string: "\(REST_URL)/artistAlbums?id=\(artistID)");
        super.init(url: url, method: "GET")
        completionParser = { (json) -> [Album] in
            var albums = [Album]();
            for item in json.arrayValue{
                albums.append(Album(json: item));
            }
            return albums;
        }
        
    }
}
