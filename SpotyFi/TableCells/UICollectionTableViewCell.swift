//
//  UICollectionTableViewCell.swift
//  SpotyFi
//
//  Created by ImanX on 3/29/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

class UICollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    public var items:[Any]!;
    public var compeletionItemCell:((_ item:Any , _ cell:UIHitCollectionViewCell) -> UIHitCollectionViewCell)!;
    public var compeletionSelectAt:((Any , Int)->Void)?;
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblNoHistory: UILabel!

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UIHitCollectionViewCell;
        let item = items[indexPath.row];
        cell.contentView.tag = indexPath.row;
        cell.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelect(sender:))))
        return compeletionItemCell(item , cell);
    }
    
    
    @objc func didSelect(sender:UITapGestureRecognizer){
        if let selectAt = compeletionSelectAt{
            let index = (sender.view?.tag)!;
            selectAt(items[index], index);
        }
    }
  
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func setIndicatorMode(isHidden:Bool)  {
                    self.indicator.isHidden = isHidden;
                    self.collection.isHidden = !isHidden;
    }
    
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.collection.register(UINib(nibName: "UIHitCollectionCell", bundle: nil), forCellWithReuseIdentifier: "cell");
        self.collection.delegate = self;
        self.collection.dataSource = self;
        self.collection.backgroundColor = .clear;
        self.backgroundColor = .clear;
       // self.lblHeader.text = "Recently Downloaded";
//
//        if let urls = PathManager.shared.getFilesURLs(){
//            self.musics = MetadataResolver().getMetas(urls: urls);
//            self.collection.reloadData();
//            self.indicator.isHidden = true;
//            self.collection.isHidden = false;
//        }else{
//            self.indicator.isHidden = true;
//            self.lblNoHistory.isHidden = false;
//
//        }

    }
    
}
