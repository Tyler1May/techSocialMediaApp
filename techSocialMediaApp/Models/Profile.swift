//
//  Profile.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 1/21/24.
//

import Foundation

struct Profile: Codable {
    var userName: String
    var bio: String
    var techInterest: String
    
    var json: [String: String] {
        ["userName": userName, "bio": bio, "techInterests": techInterest]
    }
}


