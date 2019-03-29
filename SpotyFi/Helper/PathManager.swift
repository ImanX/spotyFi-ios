//
//  PathManager.swift
//  SpotyFi
//
//  Created by ImanX on 3/26/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
class PathManager {
    public static let shared = PathManager();
    private let fileManager = FileManager.default;
    
    private init(){}
    
    public func createDirectory() -> Bool{
        guard let path = DOWNLOADED_DIR else{
            return false;
        }
        
        do{
            try fileManager.createDirectory(atPath: path.path, withIntermediateDirectories: true, attributes: nil);
            return true;
        }catch{
            return false;
        }
    }
    
    
    @discardableResult
    public func writeFile(at:URL ,to:URL? = DOWNLOADED_DIR , name:String) -> (Bool , URL?){
        guard var path  = to else{
            return (true , nil);
        }
        
        
        
        
        do{
            let data = try Data(contentsOf: at);
            path = path.appendingPathComponent(name).appendingPathExtension("mp3");
            fileManager.createFile(atPath: path.path, contents: data, attributes: nil);
            return (true , path);
        }catch{
            return (false,nil);
        }
    }
    
    
    public func hasExistDirectory()-> Bool{
        return fileManager.fileExists(atPath: (DOWNLOADED_DIR?.path)!, isDirectory: nil);
    }
    
    public func hasExistFile(file:String) -> Bool{
        let url = getFileURL(file: file);
        return fileManager.fileExists(atPath: (url.path));
    }
    
    public func getFileURL(file:String) -> URL{
        let url = DOWNLOADED_DIR;
        return (url?.appendingPathComponent(file).appendingPathExtension("mp3"))!;
        
    }
    
    public func getFilesURLs()->[URL]?{
        do{
        let dirs = try fileManager.contentsOfDirectory(at: DOWNLOADED_DIR!, includingPropertiesForKeys: nil, options: []);
        
        if dirs.count == 0 {
            return nil;
        }
        
        return dirs;
        }catch{
            return nil;
        }
    }
    
    func delete(at path:String) -> Bool {
        guard let url = URL(string: path) else{
            return false;
        }
        
        do{
           try fileManager.removeItem(at: url);
            return true;
        }catch{
            return false;
        }
    }
}
