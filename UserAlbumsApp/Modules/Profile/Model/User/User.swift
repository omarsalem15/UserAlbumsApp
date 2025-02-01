//
//  User.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 01/02/2025.
//

struct User {
    let id: Int
    let name: String
    let address: Address
    
    init(from response: UserResponse) {
        self.id = response.id
        self.name = response.name
        self.address = Address(from: response.address)
    }
}

struct Address {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    
    var fullAddress: String {
        return "\(street), \(suite), \(city), \(zipcode)"
    }
    
    init(from response: AddressResponse) {
        self.street = response.street
        self.suite = response.suite
        self.city = response.city
        self.zipcode = response.zipcode
    }
}
