//
//  PlaylistTracksRequest.swift
//  SpotyFi
//
//  Created by ImanX on 4/5/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
class PlaylistTracksRequest: Request<[Track]> {
    init(id:String){
        let url = URL.encode(string: "\(REST_URL)/playlistTracks?id=\(id)");
        super.init(url: url, method: "GET");
        completionParser = { json -> [Track] in
            var list = [Track]();
            for item in json.arrayValue{
                list.append(Track(json: item));
            }
            
            return list;
        };
    }
}
