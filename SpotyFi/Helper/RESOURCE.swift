//
//  RESOURCE.swift
//  SpotyFi
//
//  Created by ImanX on 3/9/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import AVFoundation
import XLActionController

internal var PLAYER_VIEWCONTROLLER:UIPlayerViewController!;
internal var PLAYER = PlayerProvider.shared;
internal var SOCKET:Socketer!;
public let SOCKET_URL = "http://46.101.30.103:8080/ws";
public let DOWNLOAD_URL = "http://46.101.30.103:8080/";
public let REST_URL = "http://46.101.30.103:8080/sp";
public let DOWNLOADED_DIR = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("mp3Downloaded");



public func xprint(cls:AnyClass?,any:Any){
    let className = (cls == nil) ? String() : String(describing: cls.self!)
    print("\(Bundle.appName) \(className): \(any)")
}

public func xprint(any:Any){
    xprint(cls: nil, any: any);
}

func showAlertAction(music:Music , artwork:UIImage , actions:[Action<ActionData>])-> SpotifyActionController{
    let song = music.metadata?.name;
    let artist = music.metadata?.artists?.first?.name;
    let actionController = SpotifyActionController()
    actionController.headerData = SpotifyHeaderData(title:song! , subtitle: artist!, image: artwork);
    actions.forEach { (action) in
        actionController.addAction(action);
    }
    return actionController;
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
        self.view.subviews.compactMap {  $0 as? UIVisualEffectView }.forEach { i in
            i.removeFromSuperview()
            
        }
        
    }
}


extension UIImageView{
    
    
    func loadImage(url:URL , completion:((UIImage)->Void)? = nil) {
        
        self.kf.setImage(with: url){ result in
            switch result {
            case .success(let value):
                if let completion = completion{
                    completion(value.image);
                }
                
            case .failure(let error):
                print(error)
            }
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
        
        self.subviews.forEach { (view) in
            if view is UIVisualEffectView {
                view.removeFromSuperview();
            }
        }
        
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
    
    func getPixelColor(pos: CGPoint) -> UIColor {
        
        guard let pixelData = self.image?.cgImage!.dataProvider!.data else{
            return UIColor.white;
        }
        
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.bounds.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    func  getCenterOfPixelColor() -> UIColor {
        return getPixelColor(pos: CGPoint(x: self.bounds.midX, y: self.bounds.midY))
    }
    
}

extension UIView{
    func makeGradiant(top:UIColor , bottom:UIColor = UIColor.black){
        let colorTop = top.cgColor
        let colorBottom = bottom.cgColor;
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}


extension URL{
    static func encode(string: String) -> URL {
        let encodedString = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!;
        return URL(string: encodedString)!;
    }
}

extension UITableView{
    open override func awakeFromNib() {
        super.awakeFromNib();
        self.backgroundColor = .clear;
    }
}

