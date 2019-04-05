//
//  HitSongRequest.swift
//  SpotyFi
//
//  Created by ImanX on 4/4/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
class CategoryRequest: Request<[Category]> {
    init() {
        let url = URL.encode(string: "\(REST_URL)/category");
        super.init(url: url, method: "GET")
        
        
        completionParser = { json -> [Category] in
            var categories = [Category]();
            json.forEach({ (i , item) in
                categories.append(Category(json: item));
            })
            return categories;
        }
    }
}
