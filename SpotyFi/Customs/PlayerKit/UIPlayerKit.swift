//
//  UIPlayerKit.swift
//  SpotyFi
//
//  Created by ImanX on 3/24/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

@IBDesignable
class UIPlayerKit: UIView {


    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var imgArtwork: UIImageView!
        
    override init(frame: CGRect) {
        super.init(frame: frame);
        inflate();
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        inflate();
    }
    
    override func getXibName() -> String? {
        return "UIPlayerKit";
    }
    
    override func didInflateView(view: UIView) {
        imgArtwork.dropShadow();
    }
    
    

}




extension UIView {
    @objc func getXibName() -> String? {
        fatalError("This method must override.");
    }
    
    @objc func didInflateView(view: UIView) {
        
    }
    
    
    func inflate() {
        
        guard let xibName = getXibName() else{
            return;
        }
        
        let typeOf = type(of: self);
        let view = Bundle.init(for: typeOf).loadNibNamed(xibName, owner: self, options: [:])?.first as! UIView;
        view.backgroundColor = .clear;
        view.frame = self.bounds;
        view.autoresizingMask = [.flexibleHeight , .flexibleWidth];
        didInflateView(view: view);
        self.addSubview(view);

    }
}
