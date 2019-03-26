//
//  MultipleMusicPlayer.swift
//  SpotyFi
//
//  Created by ImanX on 3/26/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
class MultipleMusicPlayer: IPlayerDelegate {
   
    
  
    private var musics:[Music]!;
    private var indexOf:Int!;
    private var music:Music!;
    
    init(musics:[Music],indexOf:Int = 0) {
        self.musics = musics;
        self.music = musics[indexOf];
        self.indexOf = indexOf;
    }
    
    func didForwardClick() {
        var index = self.indexOf + 1;
        if index >= ((self.musics?.count)!){
            index = (self.musics?.startIndex)!;
        }
        
        self.indexOf = index;
        self.music = self.musics[index];
    }
    
    func didPerviousClick() {
        var index = self.indexOf - 1;
        if index <= -1  {
            index = ((self.musics?.endIndex)! - 1);
        }
        
        self.indexOf = index;
        self.music = self.musics[index];
    }
    
    func viewDidCreate(viewController: UIPlayerViewController) {
        
    }
    
    func readyToPlay(music: Music) {
        
    }
    
    
    func getCurrentMusic() -> Music {
        return music
    }
    
    
    
    
    
}
