//
//  Photo.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 01/02/2025.
//

import Foundation

struct Photo {
    let id: Int
    let title: String
    let thumbnailUrl: URL?
    let url: URL?
}

extension Photo {
    init(from photo: PhotoResponse) {
        self.id = photo.id
        self.title = photo.title ?? ""
        if let thumbnailUrl = URL(string: photo.thumbnailUrl) {
            self.thumbnailUrl = thumbnailUrl
        }
        else {
            self.thumbnailUrl = nil
            print("error \(photo.thumbnailUrl)")
        }
        if let url = URL(string: photo.url) {
            self.url = url
        } else {
            self.url = nil
            print("error \(photo.url)")
        }
    }
}
