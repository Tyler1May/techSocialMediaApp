//
//  Post.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 1/19/24.
//

import Foundation

struct Post: Decodable, Encodable {
    var postid: Int
    var title: String
    var body: String
    var authorUserName: String
    var authorUserId: UUID
    var likes: Int
    var userLiked: Bool
    var numComments: Int
    var createdDate: String
    
    var editJson: [String: String] {
        ["postid": "postId", "title": title, "body": body]
    }
    
    var createJson: [String: String] {
        ["title": title, "body": body]
    }
}
