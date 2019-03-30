//
//  UICollectionTableViewCell.swift
//  SpotyFi
//
//  Created by ImanX on 3/29/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

class UICollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    private var musics:[Music]?;
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblNoHistory: UILabel!

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musics?.count ?? 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UIHitCollectionViewCell;
        let item = musics![indexPath.row];
        cell.imgArtwork.image = item.metadata?.photo;
        cell.lblSong.text  = item.metadata?.name;
        cell.lblArtist.text = item.metadata?.artists?.first?.name;
        return cell;
    }
    
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.collection.register(UINib(nibName: "UIHitCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell");
        self.collection.delegate = self;
        self.collection.dataSource = self;
        self.lblHeader.text = "Recently Downloaded";
        
        if let urls = PathManager.shared.getFilesURLs(){
            self.musics = MetadataResolver().getMetas(urls: urls);
            self.collection.reloadData();
            self.indicator.isHidden = true;
            self.collection.isHidden = false;
        }else{
            self.indicator.isHidden = true;
            self.lblNoHistory.isHidden = false;

        }

    }
    
}
