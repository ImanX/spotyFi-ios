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
    internal var musics:[Music]!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (musics.count) + 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        if (tableView.isFooterRow(indextPath: indexPath)) || (tableView.isHeaderRow(indexPath: indexPath)){
            let cell = UIMusicTableViewCell();
             cell.backgroundColor = .clear;
            return cell;
        }
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell") as! UIMusicTableViewCell;
        cell.item = musics[indexPath.rowWithoutWhiteSpace];
        cell.backgroundColor = .clear;
        cell.completionDidSelect = {
            let multiplePlayer = MultipleMusicPlayer(musics: self.musics, indexOf: indexPath.rowWithoutWhiteSpace);
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let item = musics[indexPath.rowWithoutWhiteSpace];
            let isSuccess = PathManager.shared.delete(at: item.downloadURL!);
            
            if isSuccess {
                musics.remove(at: indexPath.rowWithoutWhiteSpace)
                tableView.deleteRows(at: [indexPath], with: .left);
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.tableFooterView = UIView();
        return (tableView.isHeaderRow(indexPath: indexPath) ||  tableView.isFooterRow(indextPath: indexPath)) ? 50 : 100;
        
    }
    
    func reload(){
        if let tbl = tablView{
            tbl.reloadData();
        }
    }
    
    
}


extension IndexPath {
    var rowWithoutWhiteSpace:Int{
        get{
            return (row - 1);
        }
    }
}


extension UITableView{
    
    func isHeaderRow(indexPath:IndexPath) -> Bool {
        return (indexPath.row == 0);
    }
    
    func isFooterRow (indextPath:IndexPath) -> Bool{
        return indextPath.row == (numberOfRows(inSection: indextPath.section) - 1);

    }
}
