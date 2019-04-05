//
//  FeaturedPlaylistRequest.swift
//  SpotyFi
//
//  Created by ImanX on 4/5/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class FeaturedPlaylistRequest: Request<[Playlist]> {
    init() {
        let url = URL.encode(string: "\(REST_URL)/featuredPlaylists");
        super.init(url: url, method: "GET");
        completionParser = { json -> [Playlist] in
            var list = [Playlist]();
            for item in json.arrayValue{
                list.append(Playlist(json: item));
            }
            
            return list;
        };
    }
}
