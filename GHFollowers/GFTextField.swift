//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Dmitrii Fotesco on 5/17/20.
//  Copyright © 2020 Dmitrii Fotesco. All rights reserved.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        // Label Costumization, better to put it here than in a view controler.
        translatesAutoresizingMaskIntoConstraints   = false
        
        // Textfield stylization
        layer.cornerRadius                          = 10
        layer.borderWidth                           = 2
        layer.borderColor                           = UIColor.systemGray4.cgColor
        
        // Text stylization
        textColor                                   = .label
        tintColor                                   = .label
        textAlignment                               = .center
        font                                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth                   = true
        minimumFontSize                             = 12
        
        // Colors
        backgroundColor                             = .tertiarySystemBackground
        autocorrectionType                          = .no
        returnKeyType                               = .go
        placeholder                                 = "Enter a username"
        
        
    }
}
