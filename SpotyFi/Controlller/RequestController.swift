//
//  RequestController.swift
//  SpotyFi
//
//  Created by ImanX on 4/2/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class RequestController<M:Any>{
    
    private var request:Request<M>!;
    
    init(request:Request<M>) {
        self.request = request;
    }
    
    
    func apply(compeletionResult:@escaping (M)->Void , compeletionError:@escaping (Error)->Void) {
        
        var urlRequest = URLRequest(url: request.url);
        urlRequest.httpMethod = request.method;
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard response != nil else{
                compeletionError(error!);
                return;
            }
            
            
            guard let content = String(data: data!, encoding: .utf8) else{
                return
            }
            
            let json = JSON(parseJSON: content);
            let result = self.request.completionParser(json);
            
            
            
            DispatchQueue.main.async {
                compeletionResult(result);

            }
            
            
           
            
            
            
            
            }.resume();
    }

}
