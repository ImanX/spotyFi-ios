//
//  MetadataResolver.swift
//  SpotyFi
//
//  Created by ImanX on 3/26/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
import MediaPlayer
class MetadataResolver {
    
    func getMetas(urls:[URL])->[Music] {
        var musics = [Music]();
        for item in urls {
            musics.append(meta(url: item)!)  ;
        }
        
        return musics;
        
    }
    
    private func meta(url:URL)->Music?{
        let music = Music();
        music.downloadURL = url.absoluteString;
        let playerItem = AVPlayerItem(url: url)
        let metadataList = playerItem.asset.commonMetadata
        for item in metadataList {
            guard let key = item.commonKey, let value = item.value else{
                continue
            }
            
            switch key.rawValue {
            case "title" : music.metadata?.name = value as? String;
            case "artist":
                let artist = Artist();
                artist.name = value as? String;
                music.metadata?.artists = [Artist]();
                music.metadata?.artists?.append(artist);
                break;
            case "artwork":
                let image = UIImage(data: value as! Data)
                music.metadata?.photo = image;
                break;
            case "publisher": music.metadata?.publisher = value as? String;
            case "copyrights": music.metadata?.copyright = value as? String;
                
            default:
                continue
            }
            
        }
        
        return music;
        
    }
}
