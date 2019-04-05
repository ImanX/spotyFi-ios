//
//  ViewController.swift
//  SpotyFi
//
//  Created by ImanX on 3/9/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit
import Starscream
import FRadioPlayer
import SwiftyJSON;
import ESTMusicIndicator
class ViewController: UIBaseViewController{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var categories:[Category]?;
    private var playlists:[Playlist]?;
    private let sectionTitles = ["Categories","Tops" , "Recently Download"];
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.tableView.register(UINib(nibName: "UICollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionCell");
         self.tableView.register(UINib(nibName: "UIMusicTableViewCell", bundle: nil), forCellReuseIdentifier: "track_cell");
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.searchBar.delegate = self;
        
        
        
        let categoriesRequest = CategoryRequest();
        RequestController(request: categoriesRequest).apply(compeletionResult: { (categories) in
            self.categories = categories;
            self.tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .fade);
        }) { (error) in
            
        }
        
        let topFeaturesRequest = FeaturedPlaylistRequest();
        RequestController(request: topFeaturesRequest).apply(compeletionResult: { (playlists) in
            self.playlists = playlists;
            self.tableView.reloadSections(IndexSet(arrayLiteral: 1), with: .fade);
        }) { (error) in
            
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        //        if PLAYER.isPlaying{
        //            let indicator = ESTMusicIndicatorView.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 200, height: 200)));
        //           // indicator.sizeToFit();
        //            indicator.state = .playing;
        //            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: indicator);
        //            navigationItem.rightBarButtonItem?.customView!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openUIPlayerViewController)))
        //
        //
        //        }
        
        
    }
    
    override func didConnect() {
        super.didConnect();
        
    }
    
    
    
    @objc func openUIPlayerViewController() {
        UIPlayerViewController.represent();
        
    }
    
    override func didReceiveMessage(data: String) {
        self.disappearLoading();
        
        let music = Music(data: data);
        let player = SingleMusicPlayer(music: music);
        UIPlayerViewController.start(delegate: player);
        
        
    }
    
    
    //    private func setupNowPlayingInfoCenter() {
    //        UIApplication.shared.beginReceivingRemoteControlEvents();
    //        MPRemoteCommandCenter.shared().playCommand.addTarget {event in
    //          //  self.updateNowPlayingInfoCenter()
    //            return .success
    //        }
    //        MPRemoteCommandCenter.shared().pauseCommand.addTarget {event in
    //            return .success;
    //        }
    //        MPRemoteCommandCenter.shared().nextTrackCommand.addTarget {event in
    //            return .success;
    //
    //        }
    //        MPRemoteCommandCenter.shared().previousTrackCommand.addTarget {event in
    //            return .success;
    //
    //        }
    //    }
    
    
}


extension ViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let queryValue = searchBar.text;
        
        appearLoading();
        
        if (queryValue!.isSpotifyURL()){
            let request = RequestMusic(url: queryValue!.description);
            SOCKET.send(string: request.toJSON().description);
            return;
        }
        
        
        let queryRequest = QueryRequest(query: queryValue!);
        let controller = RequestController<Query>(request: queryRequest);
        controller.apply(compeletionResult: { (query) in
            UIQueryResultViewController.start(query: query, caption: queryValue!);
            self.disappearLoading();
        }) { (error) in
            self.disappearLoading();
        }
    }
    
}



extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell") as! UICollectionTableViewCell;
        
        cell.indicator.startAnimating()
        
        if indexPath.section == 0{
            fillCategories(cell: cell);
        }else if indexPath.section == 1 {
            fillHitSongs(cell: cell);
        }else {
            fillRecentylDownloaded(cell: cell);
        }
        
        return cell;
    }
    
   
    
    func fillRecentylDownloaded(cell:UICollectionTableViewCell) {
        guard let urls = PathManager.shared.getFilesURLs() else {
            cell.indicator.isHidden = true;
            cell.lblNoHistory.isHidden = false;
            return;
        }
        
        let music = MetadataResolver().getMetas(urls: urls);
        cell.setIndicatorMode(isHidden: true);
        cell.items = music;
        cell.collection.reloadData();
        cell.compeletionItemCell = { item , cell in
            let music = item as! Music;
            cell.imgArtwork.image = music.metadata?.photo;
            cell.lblSong.text = music.metadata?.name;
            cell.lblArtist.text = music.metadata?.artists?.first?.name;
            return cell;
        }
        
        
    }
    
    func fillHitSongs(cell:UICollectionTableViewCell){
    
        cell.setIndicatorMode(isHidden: true);
        cell.items = self.playlists;
        cell.collection.reloadData();
        cell.compeletionItemCell = { item , cell in
            let playlist = item as! Playlist;
            if let url = playlist.pictures.first?.URL{
                cell.imgArtwork.loadImage(url: URL(string: url)!);
            }
            
            cell.lblSong.text = playlist.name;
            cell.lblArtist.text = ("Tracks \(playlist.countOfTracks!)")
            return cell;
        }
    
    }
    
    func fillCategories(cell:UICollectionTableViewCell){
       
        cell.setIndicatorMode(isHidden: true);
        cell.items = self.categories;
        cell.collection.reloadData();
        cell.compeletionItemCell = { item , cell in
            let category = item as! Category;
            if let url = category.pictures.first?.URL{
                cell.imgArtwork.loadImage(url: URL(string: url)!);
            }
            
            cell.lblSong.text = category.name;
            cell.lblArtist.isHidden = true;
            return cell;
        }
        
        
    }
        
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section];
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.tintColor = .clear
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold);
    }
    

    
}

