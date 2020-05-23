//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Dmitrii Fotesco on 1/16/20.
//  Copyright © 2020 Dmitrii Fotesco. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        //under viewDidLoad() call the methods like logo etc
        configureLogoImageView()
        //placing the text field under the logo
        configureTextField()
        // button configuration & placing
        configureButton()
        
        createDismissTabGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    //Main Logo on the home view (both dark/light)
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")! // stringly typed, not the best way
        
        NSLayoutConstraint.activate([
            //setting up constraints
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField) // this was initialized at the top, here just placing in on the searchVC
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            // Top constraint anchored to the bottom of the logo image 48
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            
            // left / right constraints
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            //height of the textfiekd
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureButton() {
        view.addSubview(callToActionButton)
        NSLayoutConstraint.activate([
            // Top constraint anchored to the bottom of the logo image 48
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            // left / right constraints
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            //height of the textfiekd
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func createDismissTabGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
    }

}

extension SearchVC: UITextFieldDelegate {
    // what is delegate subscribing to?
    
    
}
