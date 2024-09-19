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

struct UserList: Codable {
    var users: [User]
}
