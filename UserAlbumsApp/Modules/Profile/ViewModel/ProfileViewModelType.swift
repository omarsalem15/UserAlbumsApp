//
//  ProfileViewModelType.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 03/02/2025.
//

import Foundation
import RxRelay
import RxSwift

protocol ProfileViewModelType {
    var user: BehaviorRelay<User?> { get }
    var albums: BehaviorRelay<[Album]> { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var error: PublishSubject<Error> { get }
    
    func fetchUser(userId: Int)
    func fetchAlbums(userId: Int)
}
