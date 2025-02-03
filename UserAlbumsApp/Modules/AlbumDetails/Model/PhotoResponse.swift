//
//  PhotoResponse.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 01/02/2025.
//

import Foundation

struct PhotoResponse: Codable {
    let albumId: Int
    let id: Int
    let title: String?
    let url: String
    let thumbnailUrl: String
}
