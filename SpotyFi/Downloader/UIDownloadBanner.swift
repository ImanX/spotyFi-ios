//
//  UIDonwloadBanner.swift
//  SpotyFi
//
//  Created by ImanX on 3/27/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

class UIDownloadBanner: UIView {

    @IBOutlet weak var lblTitle: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame);
        inflate();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        inflate();
    }
    
    override func getXibName() -> String? {
        return "UIDownloadBanner"
    }

}
