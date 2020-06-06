//
//  Follower.swift
//  GHFollowers
//
//  Created by Dmitrii Fotesco on 5/24/20.
//  Copyright © 2020 Dmitrii Fotesco. All rights reserved.
//

import Foundation

struct Follower: Codable {
    // safe not to make these optionals because github api always returns these two
    var login: String
    var avatarUrl: String
}
