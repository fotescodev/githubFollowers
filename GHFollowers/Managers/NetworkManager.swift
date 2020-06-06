//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Dmitrii Fotesco on 6/1/20.
//  Copyright © 2020 Dmitrii Fotesco. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared   = NetworkManager()
    let baseURL         = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseURL + username + "/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "This username created an invalid request. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, "Unable to complete your request. Check internet connection.")
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                //return back the error
                completed(nil, "Invalid response from the server. Please, try again.")
                return
            }
            
            guard let data = data else {
                completed(nil, "The data received from the server is invalid. Please try again")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                // creating an array of type Follower from the JSON data
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, "The data received from the server was invalid")    
            }
        }
        
        task.resume()
    }
}

