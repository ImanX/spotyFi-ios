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
class ViewController: UIBaseViewController , UITableViewDataSource , UITableViewDelegate{
    

    
    
    static let COUTN_OF_CELL = 3;
    
    
    @IBOutlet weak var tableView: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.COUTN_OF_CELL;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QueryCell") as! UIQueryTableViewCell;
            cell.completionDidLoading = {
                self.appearLoading();
                self.closeSoftKeyboard();
            }
            cell.completionDidEnd = {
                self.disappearLoading();
            }
            return cell;
        }
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell") as! UICollectionTableViewCell;
        cell.items = PathManager.shared.getFilesURLs();
        cell.items = MetadataResolver().getMetas(urls: PathManager.shared.getFilesURLs()!);
        cell.setIndicatorMode(isHidden: true);
        cell.compeletionItemCell = { (item , cellHit)  -> UIHitCollectionViewCell in
            let music = item as? Music;
            cellHit.imgArtwork.image = music?.metadata?.photo;
            cellHit.lblSong.text = music?.metadata?.name;
            cellHit.lblArtist.text = music?.metadata?.artists?.first?.name;
            return cellHit;
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.row == 0) ? CGFloat(200) : CGFloat(220);
    }
    

    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.tableView.register(UINib(nibName: "UIQueryTableViewCell", bundle: nil), forCellReuseIdentifier: "QueryCell");
        self.tableView.register(UINib(nibName: "UICollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectionCell");

        self.tableView.delegate = self;
        self.tableView.dataSource = self;
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

