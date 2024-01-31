//
//  CreatePost.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 1/26/24.
//

import Foundation

struct CreatePost: Codable {
    var userSecret: String
    var post: SendPost
    
    var json: [String: String] {
        ["title": post.title, "body": post.body]
    }
}

struct SendPost: Codable {
    var title: String
    var body: String
}
