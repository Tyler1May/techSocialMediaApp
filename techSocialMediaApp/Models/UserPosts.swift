//
//  UserPosts.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 1/26/24.
//

import Foundation

struct UserPosts: Decodable, Encodable {
    var postid: Int
    var title: String
    var body: String
    var authorUserName: String
    var authorUserId: UUID
    var likes: Int
    var userLiked: Bool
    var numComments: Int
    var createdDate: String
    
}
