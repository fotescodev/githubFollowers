//
//  FollowerListVCViewController.swift
//  GHFollowers
//
//  Created by Dmitrii Fotesco on 5/22/20.
//  Copyright © 2020 Dmitrii Fotesco. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {

    var username: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { (followers, errorMessage) in
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: errorMessage!, buttonTitle: "Ok")
                return
            }
            
            print("Followers.count = \(followers.count)")
            print(followers)
        }

    }
}
