//
//  UIContainerView.swift
//  SpotyFi
//
//  Created by ImanX on 3/26/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

class UIContainerView: UIView {
    var childs = [UIView]();
    
    
    func replace(v:UIView,vc:UIViewController)  {
        for i in self.childs{
            i.removeFromSuperview();
        }
        vc.view.frame = v.bounds;
        self.addSubview(v);
    }
    
    
}
