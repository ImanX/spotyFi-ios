//
//  UIDownloadedMusicsTableViewContoller.swift
//  SpotyFi
//
//  Created by ImanX on 3/26/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

class UIDownloadedMusicsTableViewContoller: UIBaseViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tablView: UITableView!
    internal var musics:[Music]!;
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musics.count + 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell") as! UIMusicTableViewCell;
        
 
        
        if indexPath.row == 0 {
            let cell = UIMusicTableViewCell();
            cell.backgroundColor = .clear;
            return cell;
        }
        
        cell.item = musics[indexPath.row - 1];
        cell.backgroundColor = .clear;
        cell.completionDidSelect = {
            let multiplePlayer = MultipleMusicPlayer(musics: self.musics, indexOf: indexPath.row - 1);
            UIPlayerViewController.start(delegate: multiplePlayer);
        }
        
        return  cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablView.backgroundColor = UIColor.clear
    }
    
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.tableFooterView = UIView();
        return (indexPath.row == 0) ? 50 : 100;
        
    }
    
    func reload(){
        if let tbl = tablView{
            tbl.reloadData();
        }
    }
    

}
