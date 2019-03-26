//
//  IPlayerDelegate.swift
//  SpotyFi
//
//  Created by ImanX on 3/26/19.
//  Copyright © 2019 ImanX. All rights reserved.
//

import Foundation
protocol IPlayerDelegate {
    func viewDidCreate(viewController:UIPlayerViewController);
    func readyToPlay(music:Music);
    func getCurrentMusic()->Music;
    func didForwardClick()->Void;
    func didPerviousClick()->Void;

}
