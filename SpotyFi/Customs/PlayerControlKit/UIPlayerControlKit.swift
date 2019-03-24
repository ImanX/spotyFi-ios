//
//  PlayerControlKit.swift
//  SpotyFi
//
//  Created by ImanX on 3/24/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import UIKit

@IBDesignable
class UIPlayerControlKit: UIView {
    
 
    
    public var state = State.Pause;
    public var compeletionPlayOrPause:(()->Void)?
    public var compeletionForward:(()->Void)?
    public var compeletionPervious:(()->Void)?


    
    
    @IBOutlet weak var imgPlay_Pause: UIImageView!
    @IBOutlet weak var imgPervious: UIImageView!
    @IBOutlet weak var imgForward: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame);
        inflate();
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        inflate();
    }
    
    
    
    func changeState(state:State)  {
        self.imgPlay_Pause.image = (state ==  State.Play) ? UIImage(named: "play") : UIImage(named: "pause");
        self.state = state;
        self.imgPlay_Pause.tintCompatColor = .white;

    }
    
    override func didInflateView(view: UIView) {
        
        let playTap = UITapGestureRecognizer(target: self, action: #selector(playClick));
        let forwardTap = UITapGestureRecognizer(target: self, action: #selector(forwardClick));
        let perviousTap = UITapGestureRecognizer(target: self, action: #selector(pervoiusClick));
        
        
        imgPlay_Pause.isUserInteractionEnabled = true;
        imgForward.isUserInteractionEnabled = true;
        imgPervious.isUserInteractionEnabled = true;
        imgPlay_Pause.addGestureRecognizer(playTap);
        imgForward.addGestureRecognizer(forwardTap);
        imgPervious.addGestureRecognizer(perviousTap);
    }
    
    override func getXibName() -> String? {
        return "UIPlayerControlKit";
    }

    
    @objc func playClick(){
        changeState(state: state == State.Play ? .Pause : .Play)
        if let comp = compeletionPlayOrPause {
            comp();
        }
    }
    
    @objc func forwardClick(){
        if let comp = compeletionForward{
            comp();
        }
    }
    
    @objc func pervoiusClick(){
        if let comp = compeletionPervious{
            comp();
        }
    }
    
    enum State {
        case Play
        case Pause
    }
}
