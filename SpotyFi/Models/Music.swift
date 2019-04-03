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
        json = JSON(parseJSON: data)["body"];
        let url = json["file_path"].stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        self.downloadURL = "\(DOWNLOAD_URL)\(url!)"
        self.metadata = Metadata(json: json);
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
    var isLocal:Bool {
        get{
            return PathManager.shared.hasExistFile(file: name!);
        }
    }
    
    
    
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
        resolveArtists(json: json["artists"]);
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

