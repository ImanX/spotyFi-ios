//
//  UIArtistDetialtViewController.swift
//  SpotyFi
//
//  Created by ImanX on 4/4/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

class UIArtistDetialtViewController: UIBaseViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgAvatar: UICircleImageView!
    @IBOutlet weak var imgArtistCover: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblFolowers: UILabel!
    
    public var artist:Artistx!;
    
    public var tracks:[Track]?;
    public var albums:[Album]?;
   
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationItem.title = "Artist";
        self.tableView.register(UINib(nibName: "UICollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "cell");
        self.tableView.register(UINib(nibName: "UIMusicTableViewCell", bundle: nil), forCellReuseIdentifier: "track_cell");
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.backgroundColor = .clear;
        


        if let url = artist.pictures.first?.URL{
            let url = URL(string: url)!;
            imgAvatar.loadImage(url: url) { (image) in
                self.view.makeGradiant(top: self.imgAvatar.getCenterOfPixelColor());
            }
         }
        
    
        
        let albumRequest = AlbumRequest(artistID: artist.id!);
        RequestController<[Album]>(request: albumRequest).apply(compeletionResult: { (albums) in
            self.albums = albums;
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic);

        }) { (error) in
            
        }
        
        
        let topSongRequest = TopSongRequest(artistID: artist.id!);
        RequestController<[Track]>(request: topSongRequest).apply(compeletionResult: { (tracks) in
            self.tracks = tracks;
            self.tableView.reloadData();
        }) { (err) in
            
        }
        
        

        
        
        lblName.text = artist.name;
        lblFolowers.text = "Folllowers \(artist.followers?.description ?? "0")"
    }
    
    
    override func didReceiveMessage(data: String) {
        let music = Music(data: data);
        let player = SingleMusicPlayer(music: music);
        UIPlayerViewController.start(delegate: player);
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.disappearLoading();
    }
    
}


extension UIArtistDetialtViewController : UITableViewDataSource , UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return 1;
        }
        
        
        
        if let count = tracks?.count {
            return count;
        }
        
        return 0;

    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UICollectionTableViewCell;
            cell.setIndicatorMode(isHidden: false);
            fillAlbums(cell: cell)
            return cell;
        }
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "track_cell") as! UIMusicTableViewCell;
        fillTrack(cell: cell, index: indexPath.row);
        return cell;
     
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold);
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Albums" : "Top Song";
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? CGFloat(150) : CGFloat(80);
    }
    
    func fillTrack(cell:UIMusicTableViewCell , index:Int){
        let track = self.tracks![index]
        if let url = track.album?.pictures.first?.URL{
            cell.imgArtwork.loadImage(url: URL(string: url)!);
        }
        cell.lblSong.text = track.name;
        cell.lblArtist.text = track.album?.name;
        cell.imgAction.image = #imageLiteral(resourceName: "play")
        cell.imgAction.tintCompatColor = .white
        
        cell.completionDidSelect = {
            self.appearLoading()
            let request = RequestMusic(url: track.externalURL!);
            SOCKET.send(string: request.toJSON().description);
        }
        

    }

    func fillAlbums(cell:UICollectionTableViewCell) {
        
        guard let safeAlbum = self.albums else{
            return;
        }

    
        cell.items = safeAlbum;
        cell.setIndicatorMode(isHidden: true);
        cell.compeletionItemCell = { item , hitCell in
            let album = item as! Album;
            if let url = album.pictures.first?.URL{
                hitCell.imgArtwork.loadImage(url: URL(string: url)!);
            }
            hitCell.lblSong.text = album.name;
            hitCell.lblArtist.text = album.releaseData
            return hitCell;
        }
        
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
