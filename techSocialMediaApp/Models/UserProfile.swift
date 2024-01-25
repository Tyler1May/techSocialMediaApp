//
//  UserProfile.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 1/24/24.
//

import Foundation

struct UserProfile: Codable {
    var firstName: String
    var lastName: String
    var userName: String
    var userUUID: String
    var bio: String
    var techInterests: String
    var posts: [Post]?
    
    static var current: UserProfile?
}
