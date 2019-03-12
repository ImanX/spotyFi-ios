//
//  Banner.swift
//  SpotyFi
//
//  Created by ImanX on 3/10/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import NotificationBannerSwift

class Banner {
    
    private var banner:StatusBarNotificationBanner?;
    
    
    class Colors: BannerColorsProtocol {
        func color(for style: BannerStyle) -> UIColor {
            return UIColor.black;
        }
    }
    
    
    public static func create() -> Banner{
        return Banner();
    }
    
    
    func show(title:String , autoDismiss:Bool = false) {
        banner = StatusBarNotificationBanner(title: title, style: .info, colors: Colors());
        banner?.autoDismiss = autoDismiss;
        banner?.bannerHeight = CGFloat(60);
        banner?.show(queuePosition: .front, bannerPosition: .bottom, queue: .default, on: nil);
    
    }
    
    func reloadLabel(title:String) {
        banner?.titleLabel?.text = title;
        banner?.setNeedsLayout();
        banner?.layoutIfNeeded();
    }
    
    
    func dismiss(delay:TimeInterval = 0){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.banner?.dismiss();
        }
    }
    
    
   
    
}
