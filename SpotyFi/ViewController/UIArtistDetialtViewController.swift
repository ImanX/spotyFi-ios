//
//  UIArtistDetialtViewController.swift
//  SpotyFi
//
//  Created by ImanX on 4/4/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

class UIArtistDetialtViewController: UIBaseViewController {
    
    
    @IBOutlet weak var imgAvatar: UICircleImageView!
    @IBOutlet weak var imgArtistCover: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblFolowers: UILabel!
    
    public var artist:Artistx!;
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationItem.title = "Artist";



        if let url = artist.pictures.first?.URL{
            let url = URL(string: url)!;
            imgAvatar.loadImage(url: url) { (image) in
                self.view.makeGradiant(top: self.imgAvatar.getCenterOfPixelColor());
            }
            


           // imgArtistCover.makeBlur();
        }
        
    
        
        

        
        
        lblName.text = artist.name;
        lblFolowers.text = "Folllowers \(artist.followers?.description ?? "0")"
    }
    
}

extension UIArtistDetialtViewController{
 class func start(artist:Artistx){
    let vc = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(type: UIArtistDetialtViewController.self);
    vc.artist = artist;
    if let navigationVC = UIApplication.topViewController as? UINavigationController{
        navigationVC.pushViewController(vc, animated: true);
    }
    }
}
