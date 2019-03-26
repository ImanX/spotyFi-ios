//
//  PlayerSingleStart.swift
//  SpotyFi
//
//  Created by ImanX on 3/26/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
class SingleMusicPlayer: IPlayerDelegate {
    
    
    
    private var music:Music!;
    
    init(music:Music) {
        self.music = music;
        
        
        
        if (music.metadata?.isLocal)!{
            let localPath = PathManager.shared.getFileURL(file: (music.metadata?.name)!);
            self.music.downloadURL = localPath.absoluteString;
        }
    }

    
    func didForwardClick() {
        
    }
    
    func didPerviousClick() {
        
    }
    
    
    func readyToPlay(music: Music) {
        
    }
    

    
    func getCurrentMusic() -> Music {
        return music;
    }
    

    
    func viewDidCreate(viewController: UIPlayerViewController) {
        viewController.playerController.imgForward.tintCompatColor = .gray;
        viewController.playerController.imgPervious.tintCompatColor = .gray;
        viewController.playerController.imgPervious.isUserInteractionEnabled = false;
        viewController.playerController.imgForward.isUserInteractionEnabled = false;
    }
    
    
    
    
}
