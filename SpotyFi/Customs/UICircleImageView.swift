//
//  UICircleImageView.swift
//  SpotyFi
//
//  Created by ImanX on 4/4/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

class UICircleImageView: UIImageView {

    override func layoutSubviews() {
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }

}
