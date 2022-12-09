//
//  Users.swift
//  Tee'sApp
//
//  Created by La Pommeray, Thalia on 11/15/22.
//

import Foundation

struct User: Codable{
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address // Address Struct
    let phone: String
    let website: String
    let company: Company // Company Struct
}

struct Address: Codable{
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

struct Geo: Codable {
    let lat: String
    let lng: String
    }

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}

extension User{
    static func dummyUser()->User{
        User(id: 123, name: "Thalia", username: "tee", email: "tee@gmail.com", address: Address(street: "123 Tee Drive", suite: "Suite 754", city: "Orlando", zipcode: "32828", geo: Geo(lat: "123", lng: "987")), phone: "1234567890", website: "tee.dev", company: Company(name: "Rbc", catchPhrase: "something something", bs: "something"))
    }
}



