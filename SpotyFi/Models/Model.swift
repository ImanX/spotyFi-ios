//
//  Model.swift
//  SpotyFi
//
//  Created by ImanX on 3/23/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import SwiftyJSON
class Model {
    
    var json = JSON();
    
    
    func toJSON()->JSON{
        fatalError("this method must to override")
    }



}
