//
//  UIMusicTableViewCell.swift
//  SpotyFi
//
//  Created by ImanX on 3/26/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit
import XLActionController
class UIMusicTableViewCell: UITableViewCell {
    
    

    internal var item:Music!{
        didSet{
            imgArtwork.image = item.metadata?.photo;
            lblSong.text = item.metadata?.name;
            lblArtist.text = item.metadata?.artists?.first?.name;
            
        }
        
    }
    
    
    public var completionDidSelect:(()->Void)?
    @IBOutlet weak var imgAction: UIImageView!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblSong: UILabel!
    @IBOutlet weak var imgArtwork: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(didSelect));
        let shareTap = UITapGestureRecognizer(target: self, action: #selector(didShareClick));
        self.containerView.addGestureRecognizer(tap);
        self.imgAction.addGestureRecognizer(shareTap);
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
        

    }
    
  
    override func didSelect() {
        if let completion = completionDidSelect{
            completion();
        }
    }
    

    override func didShareClick() {
        let topViewController = UIApplication.topViewController;
        let song = item?.metadata?.name;
        let artist = item?.metadata?.artists?.first?.name;
        let actionController = SpotifyActionController()
        actionController.headerData = SpotifyHeaderData(title:song! ,
                                                        subtitle: artist!,
                                                        image: (item.metadata?.photo)!);
        
        
        let shareAction = Action(ActionData(title: "Share", image: #imageLiteral(resourceName: "sharer")), style: .default) { (action) in
            let url = URL(string: (self.item?.downloadURL)!);
            let a = UIActivityViewController(activityItems: [url], applicationActivities: nil);
            
            topViewController?.present(a,
                         animated: true,
                         completion: nil)
        }
        
   
        actionController.addAction(shareAction);
        topViewController?.present(actionController, animated: true, completion: nil);
    }

}


extension UITableViewCell{
    
    

    @objc func didSelect(){
    }
    @objc func didShareClick(){
      
    }
}
