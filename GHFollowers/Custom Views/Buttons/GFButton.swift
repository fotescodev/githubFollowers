//
//  GFButton.swift
//  GHFollowers
//
//  Created by Dmitrii Fotesco on 5/17/20.
//  Copyright © 2020 Dmitrii Fotesco. All rights reserved.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Creating custom initializer to pick up proper color
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        
        configure()
    }
    
    private func configure() {
        // setting up the look of the button
        layer.cornerRadius          = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font            = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
       
    }

}
