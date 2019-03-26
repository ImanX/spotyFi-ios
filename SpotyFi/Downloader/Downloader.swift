//
//  Downloader.swift
//  SpotyFi
//
//  Created by ImanX on 3/25/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import Digger
class Downloader {
    
    
    init() {
        DiggerManager.shared.logLevel = .none;
    }
    
    func enqueue(url:URL,compeltionHandler:@escaping (_ percents:Float?,_ path:URL?, _ error:Error?)->Void) {
        Digger
            .download(url)
            .completion { (result) in
                switch(result){
                case .failure(let e):
                    compeltionHandler(nil , nil , e);
                    break;
                case .success(let url):
                    compeltionHandler(1.0,url , nil)
                    DiggerCache.cleanDownloadFiles();
                    DiggerCache.cleanDownloadTempFiles();
                    break;
                }
                
            }.progress { (progress) in
                compeltionHandler(Float(progress.fractionCompleted),nil , nil);
            }
        
        
    }
}
