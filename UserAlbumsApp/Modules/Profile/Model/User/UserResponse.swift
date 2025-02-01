//
//  UserResponse.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 01/02/2025.
//

struct UserResponse: Codable {
    let id: Int
    let name: String
    let address: AddressResponse
}

struct AddressResponse: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
}

