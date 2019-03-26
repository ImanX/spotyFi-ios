//
//  Music.swift
//  SpotyFi
//
//  Created by ImanX on 3/23/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Music: Model {
    
    var downloadURL:String?;
    var metadata:Metadata?;
    
    
    init(data:String) {
        super.init();
        json = JSON(parseJSON: data);
        let url = json["uri"].stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        self.downloadURL = "\(DOWNLOAD_URL)\(url!)"
        self.metadata = Metadata(json: json["meta_tags"]);
    }
    
    override init() {
        metadata = Metadata();
    }
    
    override func toJSON() -> JSON {
        return json;
    }
}

class Metadata{
    
    var releaseDate:String?;
    var copyright:String?;
    var publisher:String?;
    var genre:String?;
    var name:String?
    var lyrics:String?;
    var artists:[Artist]?;
    var image:[URL]?;
    var photo:UIImage?;
    
    
    
    init() {
    }
    
    init(json:JSON) {
        releaseDate = json["release_date"].string;
        copyright = json["copyright"].string;
        publisher = json["publisher"].string;
        genre = json["genre"].string;
        name = json["name"].string;
        lyrics = json["lyrics"].string;
        

        
        
    
       
    
        resolveImages(json:  json["album"]["images"]);
        resolveArtists(json: json["album"]["artists"]);
    }
    
    func resolveArtists(json:JSON)   {
        guard let array = json.array else{
            return;
        }
        
        artists = [Artist]();
        
        for item in array {
            artists?.append(Artist.init(json: item))
        }
    }
    
    func resolveImages(json:JSON)  {
     
        guard let array = json.array else{
            return;
        }
        
        
        image = [URL]();
        
        for i in array{
            let url = URL(string: i["url"].string!);
            image?.append(url!);
        }
    }
}

class Artist {
    
    var name:String?;
    var url:String?;
    
    init() {
        
    }
    
    init(json:JSON) {
        name = json["name"].string;
        url = json["external_urls"]["spotify"].string;
    }
    
    
    
}

class Image {
    var items:[String]?;

    init(json:JSON) {
        
      
    }
    
}







//"id":"121312313123",
//"song":"https://open.spotify.com/track/2DGa7iaidT5s0qnINlwMjJ",
//"meta_tags":{
//    "artists":[
//    {
//    "id":"7vk5e3vY1uw9plTHJAMwjN",
//    "name":"Alan Walker",
//    "type":"artist",
//    "href":"https://api.spotify.com/v1/artists/7vk5e3vY1uw9plTHJAMwjN",
//    "external_urls":{
//    "spotify":"https://open.spotify.com/artist/7vk5e3vY1uw9plTHJAMwjN"
//    },
//    "uri":"spotify:artist:7vk5e3vY1uw9plTHJAMwjN"
//    }
//    ],
//    "copyright":"(P) 2017 MER under exclusive license to Sony Music Entertainment Sweden AB",
//    "total_tracks":1,
//    "publisher":"MER Musikk",
//    "href":"https://api.spotify.com/v1/tracks/2DGa7iaidT5s0qnINlwMjJ",
//    "disc_number":1,
//    "type":"track",
//    "genre":"Tropical House",
//    "name":"The Spectre",
//    "album":{
//        "artists":[
//        {
//        "id":"7vk5e3vY1uw9plTHJAMwjN",
//        "name":"Alan Walker",
//        "type":"artist",
//        "href":"https://api.spotify.com/v1/artists/7vk5e3vY1uw9plTHJAMwjN",
//        "external_urls":{
//        "spotify":"https://open.spotify.com/artist/7vk5e3vY1uw9plTHJAMwjN"
//        },
//        "uri":"spotify:artist:7vk5e3vY1uw9plTHJAMwjN"
//        }
//        ],
//        "images":[
//        {
//        "height":640,
//        "width":640,
//        "url":"https://i.scdn.co/image/5f5ff00bae8a4e5272c82b9cd6c04f86ffa373f1"
//        },
//        {
//        "height":300,
//        "width":300,
//        "url":"https://i.scdn.co/image/2f05ef4fa8ca120fb9b64546e9e10d7147d7cf17"
//        },
//        {
//        "height":64,
//        "width":64,
//        "url":"https://i.scdn.co/image/712e48487fed9fef11f52237367ad4d46045cb17"
//        }
//        ],
//        "total_tracks":1,
//        "release_date_precision":"day",
//        "type":"album",
//        "href":"https://api.spotify.com/v1/albums/1IKRstg3XuCuLWeCg3oaAW",
//        "album_type":"single",
//        "release_date":"2017-09-15",
//        "name":"The Spectre",
//        "external_urls":{
//            "spotify":"https://open.spotify.com/album/1IKRstg3XuCuLWeCg3oaAW"
//        },
//        "id":"1IKRstg3XuCuLWeCg3oaAW",
//        "uri":"spotify:album:1IKRstg3XuCuLWeCg3oaAW"
//    },
//    "preview_url":"https://p.scdn.co/mp3-preview/0da077aef7e2972ee5374fe65d4cb39af3b3dfb8?cid=4fe3fecfe5334023a1472516cc99d805",
//    "uri":"spotify:track:2DGa7iaidT5s0qnINlwMjJ",
//    "explicit":false,
//    "popularity":78,
//    "duration":193.787,
//    "external_ids":{
//        "isrc":"NOG841713010"
//    },
//    "is_local":false,
//    "release_date":"2017-09-15",
//    "year":"2017",
//    "spotify_metadata":true,
//    "external_urls":{
//        "spotify":"https://open.spotify.com/track/2DGa7iaidT5s0qnINlwMjJ"
//    },
//    "id":"2DGa7iaidT5s0qnINlwMjJ",
//    "lyrics":"Hello, hello\nCan you hear me, as I scream your name\nHello, hello\nDo you meet me, before I fade away\n\nIs this the place that I call home\nTo find what I've become\nWalk along the path unknown\nWe live, we love, we lie\n\nDeep in the dark I don't need the light\nThere's a ghost inside me\nIt all belongs to the other side\nWe live, we love, we lie\n\n(We live, we love, we lie)\n\nHello, hello\nNice to meet your, voice inside my head\nHello, hello\nI believe you\nHow can I forget\n\nIs this the place that I call home\nTo find what I've become\nWalk along the path unknown\nWe live, we love, we lie\n\nDeep in the dark I don't need the light\nThere's a ghost inside me\nIt all belongs to the other side\nWe live, we love, we lie\n\n(We live, we love, we lie)\n\nWe live, we love, we lie",
//    "track_number":1
//},
//"uri":"dl/Alan Walker - The Spectre.mp3",
//"user":{
//}
