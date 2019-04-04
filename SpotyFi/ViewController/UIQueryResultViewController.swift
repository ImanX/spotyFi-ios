//
//  UIResultViewController.swift
//  SpotyFi
//
//  Created by ImanX on 4/2/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

class UIQueryResultViewController: UIBaseViewController {
    
    
    
    private let sectionTitles = ["Artists", "Tracks" , "Albums"];
    
   
    @IBOutlet weak var tableView: UITableView!
    private var query:Query!;
    private var captionOfQuery:String!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.register(UINib(nibName: "UICollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "cell");
        self.navigationItem.title = "Results of \(captionOfQuery!)";

    }
    


}



extension UIQueryResultViewController :  UITableViewDelegate , UITableViewDataSource{

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  1;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UICollectionTableViewCell;
        cell.setIndicatorMode(isHidden: true);
        if indexPath.section  == 0 && query.artists.count > 0{
            fillArtist(cell: cell);
        } else if indexPath.section == 1 && query.tracks.count > 0{
            fillTrack(cell: cell);
        } else if indexPath.section == 2 && query.albums.count > 0{
            fillAlbum(cell: cell);
        }else{
            cell.isHidden = true;
        }
        
        return cell;


       // return UITableViewCell();
        
    }
    
    func tableView(_ table: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return CGFloat(180);
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section];
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.tintColor = .clear
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold);
    }

}

extension UIQueryResultViewController {
    func fillArtist(cell:UICollectionTableViewCell) {
        cell.items = query.artists;
        cell.compeletionItemCell = { (item , cell) -> UIHitCollectionViewCell in
            let item = item as? Artistx;
            if let url = item?.pictures.first?.URL {
                cell.imgArtwork.loadImage(url: URL(string: url)!)
            }
            cell.lblArtist.text = ("Follow \(item?.followers?.description ?? "0" )");
            cell.lblSong.text = item?.name;
            return cell;
        }
        
        cell.compeletionSelectAt = { item , index in
            UIArtistDetialtViewController.start(artist: item as! Artistx);
        }
        
        
        
    }
    
    func fillTrack(cell:UICollectionTableViewCell){
        cell.items = query.tracks;
        cell.compeletionItemCell = { (item , cell) -> UIHitCollectionViewCell in
            let item = item as? Track;
            if let url = item?.album?.pictures.first?.URL {
                cell.imgArtwork.loadImage(url: URL(string: url)!)
            }
            cell.lblArtist.text = item?.artists.first?.name;
            cell.lblSong.text =  item?.name;
            return cell;
        }
        
        cell.compeletionSelectAt = { item , index in
            
        }
    }
    func fillAlbum(cell:UICollectionTableViewCell){
        cell.items = query.albums;
        cell.compeletionItemCell = { (item , cell) -> UIHitCollectionViewCell in
            let item = item as? Album;
            if let url = item?.pictures.first?.URL {
                cell.imgArtwork.loadImage(url: URL(string: url)!)
            }
            cell.lblArtist.text = item?.artists.first?.name;
            cell.lblSong.text =  item?.name;
            return cell;
        }
        
        cell.compeletionSelectAt = { item , index in
            
        }
    }
}

extension UIQueryResultViewController{
    
    
    public class func start(query:Query,caption:String){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(type: UIQueryResultViewController.self);
        vc.query = query;
        vc.captionOfQuery = caption;
        if let navigationController = UIApplication.topViewController as? UINavigationController{
            navigationController.pushViewController(vc, animated: true);
        }
        
    }
}
