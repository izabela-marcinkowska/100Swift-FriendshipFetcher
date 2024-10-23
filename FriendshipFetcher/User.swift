//
//  User.swift
//  FriendshipFetcher
//
//  Created by Izabela Marcinkowska on 2024-10-23.
//

import Foundation

struct Response: Codable {
    var results: [User]
}

struct User: Codable, Identifiable, Hashable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
}

struct Friend: Codable, Hashable {
    var id: UUID
    var name: String
}
