//
//  User.swift
//  ContactList-App
//

import Foundation

struct UserBase: Codable {
    let results: [RandomUser]
}

struct RandomUser: Codable{
    let gender: String
    let name: UserName
}

struct UserName: Codable{
    let title: String
    let first: String
    let last: String
}
