//
//  jsonReader.swift
//  ios
//
//  Created by Yan on 19.09.2024.
//

struct User: Codable {
    let username: String
    let password: String
}

// Define UserList that holds an array of users
struct UserList: Codable {
    var users: [User] // Make this mutable by using `var`
}
