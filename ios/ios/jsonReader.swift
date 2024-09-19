//
//  jsonReader.swift
//  ios
//
//  Created by Yan on 19.09.2024.
//

import Foundation

// Define User model matching JSON structure
struct User: Codable {
    let username: String
    let password: String
}

// Define UserList that holds an array of users
struct UserList: Codable {
    let users: [User]
}


