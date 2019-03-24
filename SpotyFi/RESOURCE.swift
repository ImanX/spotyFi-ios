//
//  RESOURCE.swift
//  SpotyFi
//
//  Created by ImanX on 3/9/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import UIKit
import Matisse
import AVFoundation

public let SOCKET_URL = "http://46.101.30.103:8089/";
public let DOWNLOAD_URL = "http://46.101.30.103:8080/"
public let SOCKET_PORT:Int32 = 80;
internal var PLAYER = PlayerProvider.shared;

public func xprint(cls:AnyClass?,any:Any){
    let className = (cls == nil) ? String() : String(describing: cls.self!)
    print("\(Bundle.appName) \(className): \(any)")
}

public func xprint(any:Any){
    xprint(cls: nil, any: any);
}


extension Bundle{
    public static var appName:String = Bundle.main.infoDictionary?["CFBundleName"] as! String;
}


extension UIStoryboard{
    func  instantiateViewController<vc:UIViewController>(type:vc.Type)->vc {
        let name = String(describing: type);
        return instantiateViewController(withIdentifier: name) as! vc;
    }
}

extension UIApplication {
    static var topViewController = UIApplication.shared.keyWindow?.rootViewController;
}

extension String {
    func isSpotifyURL() -> Bool {
        guard let url = URL(string: self) else{
            return false;
        }
        
        guard url.host == "open.spotify.com" else{
            return false;
        }
        
        return true;
    }
    
    func replace(of :String , to: String) -> String {
        return self.replacingOccurrences(of: of, with: to);
    }
}


extension UIBaseViewController : UITextFieldDelegate{
    @objc func closeSoftKeyboard(){
        self.view.endEditing(true);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeSoftKeyboard));
        self.view.addGestureRecognizer(tap);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        closeSoftKeyboard();
        return true;
    }
    
    
}


extension UIBaseViewController{
    func appearLoading(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()
        
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        
        self.view.addSubview(blurEffectView)
    }
    
    func disappearLoading(){
        self.view.subviews.compactMap {  $0 as? UIVisualEffectView }.forEach {
            $0.removeFromSuperview()
        }
    }
}


extension UIImageView{
    func loadImage(url:URL){
        Matisse.load(url).fetch { (req, image, err) in
            self.image = image;
            //self.makeBlur();
        }
        
    }
    
    func dropShadow() {
        let shadowSize : CGFloat = 5.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.frame.size.width + shadowSize,
                                                   height: self.frame.size.height + shadowSize))
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func makeBlur() {
//        let imageToBlur = CIImage(image: self.image!)
//        let blurfilter = CIFilter(name: "CIGaussianBlur")
//        blurfilter!.setValue(imageToBlur, forKey: "inputImage")
//        let resultImage = blurfilter!.value(forKey: "outputImage") as! CIImage
//        let blurredImage = UIImage(ciImage: resultImage)
//        self.image = blurredImage
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds;
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView);
        
    }
    
    
    @IBInspectable
    public var tintCompatColor: UIColor {
        get{
            return self.tintColor;
        }
        
        set{
            self.image = self.image?.withRenderingMode(.alwaysTemplate)
            self.tintColor = newValue;
        }
    }
    
}

