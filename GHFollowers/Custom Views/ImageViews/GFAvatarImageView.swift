//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Dmitrii Fotesco on 6/6/20.
//  Copyright © 2020 Dmitrii Fotesco. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    
    // Using the Network Manager singleton to avoid multiple instances of cache
    let cache = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from urlString: String) {
        
        // Checking whether the image is available in the cach object, using the URL as key
        if let image = cache.object(forKey: NSString(string: urlString)) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        // Since all the errors are being handled and parsed in the Network Manager, I decided to place the actual network call here to avoide the clutter.
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            // initializing UIImage from data
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: NSString(string: urlString))
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        
        task.resume()
    }
}
