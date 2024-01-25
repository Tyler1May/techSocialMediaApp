//
//  Comments.swift
//  techSocialMediaApp
//
//  Created by Tyler May on 1/19/24.
//

import Foundation

struct Comments: Codable {
    var commentId: Int
    var body: String
    var userName: String
    var userId: UUID
    var createdDate: Date
}
