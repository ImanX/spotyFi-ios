//
//  UIQueryTableViewCell.swift
//  SpotyFi
//
//  Created by ImanX on 3/29/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

class UIQueryTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var edtQuery: UITextField!
    public var completionDidLoading:(()->Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib();
        self.edtQuery.delegate = self;
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.returnKeyType == .go , (textField.text?.isSpotifyURL())! else{
            return false;
        }
        
        guard let url = URL(string: textField.text!) else {
            return false;
        }
        
        
        
        
        if let comp = completionDidLoading {
            comp();
        }
        
        let request = RequestMusic(url: url.description);
        SOCKET.send(string: request.toJSON().description);
        
        return true;
        
    }
    
    
}

extension UITableViewCell{
    open override func awakeFromNib() {
        super.awakeFromNib();
        self.selectionStyle = .none

    }
}
