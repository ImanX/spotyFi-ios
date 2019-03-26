//
//  UIRecentlyDownloadViewController.swift
//  SpotyFi
//
//  Created by ImanX on 3/26/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

class UIRecentlyDownloadViewController: UIBaseViewController {
    
    @IBOutlet weak var container: UIContainerView!
    
    lazy var emptyStateViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(type: UIEmptyStateViewController.self)
    lazy var downloadedMusicViewController = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(type: UIDownloadedMusicsTableViewContoller.self)
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        let urls = PathManager.shared.getFilesURLs();
        
        guard let safeUrls = urls else{
            container.replace(v: emptyStateViewController.view, vc: self);
            return
        }
        
        
        
        
        
        
        downloadedMusicViewController.musics = MetadataResolver().getMetas(urls: safeUrls);
        downloadedMusicViewController.reload();
        container.replace(v: downloadedMusicViewController.view, vc: self);
        
        
        
    }
}
