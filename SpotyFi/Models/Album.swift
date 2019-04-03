//
//  Albume.swift
//  SpotyFi
//
//  Created by ImanX on 4/3/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Album : Model {
    public var name:String?;
    public var artists:[Artistx] = [];
    public var pictures:[Picture] = [];
    public var releaseData:String?;
    public var externalURL:String?;
    public var releaseDatePrecision:String?;
    
    init(json:JSON) {
        name = json["name"].string;
        externalURL = json["external_urls"]["external_urls"].string;
        releaseData = json["release_date"].string;
        releaseDatePrecision = json["release_date_precision"].string;
        
        for item in json["images"].arrayValue{
            let pic = Picture();
            pic.URL = item["url"].string;
            pictures.append(pic);
        }
        
        for item in json["artists"].arrayValue{
            artists.append(Artistx(json: item));
        }
        
    }

}
