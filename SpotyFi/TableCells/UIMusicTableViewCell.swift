//
//  UIMusicTableViewCell.swift
//  SpotyFi
//
//  Created by ImanX on 3/26/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

class UIMusicTableViewCell: UITableViewCell {
    
    

    internal var item:Music!{
        didSet{
            imgArtwork.image = item.metadata?.photo;
            lblSong.text = item.metadata?.name;
            lblArtist.text = item.metadata?.artists?.first?.name;
        }
        
    }
    
    @IBOutlet weak var imgAction: UIImageView!
    @IBOutlet weak var lblArtist: UILabel!
    @IBOutlet weak var lblSong: UILabel!
    @IBOutlet weak var imgArtwork: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }
    
  
    override func didSelect() {
        UIPlayerViewController.start(music: item);
    }
    


}


extension UITableViewCell{
    
    
    
    
    open override func awakeFromNib() {
        super.awakeFromNib();
        let tap = UITapGestureRecognizer(target: self, action: #selector(didSelect));
        self.contentView.addGestureRecognizer(tap);
    }
    
    
    
    @objc func didSelect(){
    }
}
