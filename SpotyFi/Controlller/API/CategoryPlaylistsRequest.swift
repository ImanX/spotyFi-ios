//
//  FeaturedPlaylistsRequest.swift
//  SpotyFi
//
//  Created by ImanX on 4/4/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class CategoryPlaylistsRequest: Request<[Playlist]> {
    init(id:String) {
        let url = URL.encode(string: "\(REST_URL)/categoryPlaylists?id=\(id)")
        super.init(url: url, method: "GET")
        completionParser = { json -> [Playlist] in
            var playlists = [Playlist]();
            for item in json.arrayValue{
                playlists.append(Playlist(json: item));
            }
            return playlists;
        }
    }
}
