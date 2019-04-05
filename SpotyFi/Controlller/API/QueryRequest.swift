//
//  QueryRequest.swift
//  SpotyFi
//
//  Created by ImanX on 4/3/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
class QueryRequest: Request<Query> {


    init(query:String){
        let url = URL.encode(string: "\(REST_URL)/search?q=\(query)");
        super.init(url: url, method: "GET")
        completionParser = { (json) -> Query in
            return Query(json: json);
        }
        
    }
    
    
    
    

}

