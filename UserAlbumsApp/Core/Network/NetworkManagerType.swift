//
//  NetworkManagerType.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 03/02/2025.
//

import Foundation
import RxSwift

protocol NetworkManagerType {
    func fetchUsers() -> Single<[UserResponse]>
    func fetchAlbums(forUserId userId: Int) -> Single<[Album]>
    func fetchPhotos(albumId: Int) -> Single<[PhotoResponse]>
}
