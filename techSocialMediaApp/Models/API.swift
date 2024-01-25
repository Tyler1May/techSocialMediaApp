//
//  API.swift
//  techSocialMediaApp
//
//  Created by Brayden Lemke on 10/25/22.
//

import Foundation

enum APICallErrors: Error, LocalizedError {
    case userNotFound
    case invalidUserSecret
}

struct API {
    static var url = "https://tech-social-media-app.fly.dev"
    static var userProfile = "userProfile"
    static var updateProfile = "updateProfile"
    static var posts = "posts"
    static var postCreate = "createPost"
    
    static func fetchUserProfile() async throws -> UserProfile {
        let url = URL(string: "\(API.url)/\(API.userProfile)")!
        
        
        guard let currentUser = User.current else {
            throw APICallErrors.userNotFound
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            "userUUID": "\(currentUser.userUUID.uuidString)",
            "userSecret": "\(currentUser.secret.uuidString)"
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let (data, response) = try await URLSession.shared.data(from: components.url!)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APICallErrors.userNotFound
        }
        
        let decoder = JSONDecoder()
        let userProfile = try decoder.decode(UserProfile.self, from: data)
        UserProfile.current = userProfile
        return userProfile
    }
    
    static func editUserProfile(_ newProfile: Profile) async throws {
        let url = URL(string: "\(API.url)/\(API.updateProfile)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let secret = User.current?.secret else {
            throw APICallErrors.invalidUserSecret
        }
        let parameters: [String: Any] = [
            "userSecret": secret.uuidString,
            "profile": newProfile.json
        ]
        
        print(parameters)
        request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            
        let (data, response) = try await URLSession.shared.data(for: request)
            
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APICallErrors.userNotFound
        }
        
    }
    
    static func createPost(_ userPost: Post) async throws -> Post {
        let url = URL(string: "\(API.url)/\(API.postCreate)")!
        
        guard let secret = User.current?.secret else {
            throw APICallErrors.invalidUserSecret
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            "userSecret": "\(secret)",
            "post": "\(userPost.createJson)"
        ].map { URLQueryItem(name: $0.key, value: $0.value)}
        
        let (data, response) = try await URLSession.shared.data(from: components.url!)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APICallErrors.invalidUserSecret
        }
        
        let decoder = JSONDecoder()
        let post = try decoder.decode(Post.self, from: data)
        return post
    }
    
    static func getPosts() async throws -> [Post] {
        let url = URL(string: "\(API.url)/\(API.posts)")!
        
        guard let currentUser = User.current else {
            throw APICallErrors.userNotFound
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            "userSecret": "\(currentUser.secret.uuidString)",
            "pageNumber": "0"
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let (data, response ) = try await URLSession.shared.data(from: components.url!)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APICallErrors.invalidUserSecret
        }
        
        let decoder = JSONDecoder()
        let posts = try decoder.decode([Post].self, from: data)
        return posts
    }
    
    static func deletePosts(_ postID: Post) async throws {
        let url = URL(string: "\(API.url)/\(API.posts)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let secret = User.current?.secret else {
            throw APICallErrors.invalidUserSecret
        }
        
        let parameters: [String: Any] = [
            "userSecret": secret.uuidString,
            "postid": postID.postid
        ]
    }
    
}
