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

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
