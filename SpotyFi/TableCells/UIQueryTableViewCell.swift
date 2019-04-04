//
//  UIQueryTableViewCell.swift
//  SpotyFi
//
//  Created by ImanX on 3/29/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

class UIQueryTableViewCell: UITableViewCell, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!

    public var completionDidLoading:(()->Void)!;
    public var completionDidEnd:(()->Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib();
        self.searchBar.delegate = self;
      
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard textField.returnKeyType == .go  else{
//            return false;
//        }
//
        let queryValue = searchBar.text;
        completionDidLoading();
        
        if (queryValue!.isSpotifyURL()){
            let request = RequestMusic(url: queryValue!.description);
            SOCKET.send(string: request.toJSON().description);
            return;
        }
        
        
        let queryRequest = QueryRequest(query: queryValue!);
        let controller = RequestController<Query>(request: queryRequest);
        controller.apply(compeletionResult: { (query) in
            UIQueryResultViewController.start(query: query, caption: queryValue!);
            self.completionDidEnd();
        }) { (error) in
            self.completionDidEnd();
        }
        
        
        
    }

    
    
 
    
    
}

extension UITableViewCell{
    open override func awakeFromNib() {
        super.awakeFromNib();
        self.selectionStyle = .none

    }
}
