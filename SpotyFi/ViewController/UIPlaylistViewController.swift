//
//  UIPlayllistViewContrroller.swift
//  SpotyFi
//
//  Created by ImanX on 4/5/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

class UIPlaylistViewController: UIBaseViewController {
    
    private var playlist:Playlist!;
    private var tracks:[Track]?;


    
    @IBOutlet weak var imgArtwork: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTrackNo: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.navigationItem.title = "Playlist";
        self.tableView.delegate = self;
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "UIMusicTableViewCell", bundle: nil), forCellReuseIdentifier: "cell");
        
        
        let playlistTrackRequest = PlaylistTracksRequest(id: playlist.id!);
        RequestController(request: playlistTrackRequest).apply(compeletionResult: { (tracks) in
            self.tracks = tracks;
            self.tableView.isHidden = false;
            self.indicator.isHidden = true;
            self.tableView.reloadSections(IndexSet(arrayLiteral: 0), with:.automatic)
            
        }) { (error) in
            
        }

        
        if let url = playlist.pictures.first?.URL {
            imgArtwork.loadImage(url: URL(string: url)!) { (image) in
                self.performGradiant(color: self.imgArtwork.getCenterOfPixelColor());
            }
        }
        
        self.lblName.text = playlist.name;
        self.lblTrackNo.text = "\(playlist.countOfTracks?.description ?? "0") Tracks";
    }
    
}




extension UIPlaylistViewController{
    class func start(playlist:Playlist) {
        let vc = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(type: UIPlaylistViewController.self);
        vc.playlist = playlist;
        if let navigationController = UIApplication.topViewController as? UINavigationController{
            navigationController.pushViewController(vc, animated: false);
        }
    }
}

extension UIPlaylistViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UIMusicTableViewCell;
        let track = tracks![indexPath.row];
        
        cell.lblSong.text = track.name;
        cell.lblArtist.text = track.artists.first?.name;
        cell.imgArtwork.image = nil;
        
        

        
        return cell;
    }
    

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.tag = indexPath.row;
        let track = self.tracks![indexPath.row];
        if let url = track.album?.pictures.first?.URL{
            if cell.tag == indexPath.row {
                (cell as! UIMusicTableViewCell).imgArtwork.loadImage(url: URL(string: url)!);
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100);
    }
    
}
    

