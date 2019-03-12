//
//  ViewController.swift
//  SpotyFi
//
//  Created by ImanX on 3/9/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit
import Starscream
class ViewController: UIBaseViewController{

    
    

    override func viewDidLoad() {
        super.viewDidLoad();
    }

    override func didReceiveMessage(data: String) {
        xprint(any: data);
    }
}

