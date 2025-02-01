//
//  ProfileViewModel.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 01/02/2025.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class ProfileViewModel {
    private let networkManager = NetworkManager.shared
    private let disposeBag = DisposeBag()
    
    let user = BehaviorRelay<User?>(value: nil)
    let albums = BehaviorRelay<[Album]>(value: [])
    
    func fetchUser(userId: Int) {
        networkManager.fetchUsers()
            .subscribe(onSuccess: { [weak self] users in
                if let user = users.first {
                    let userUIModel = User(from: user)
                    self?.user.accept(userUIModel)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func fetchAlbums(userId: Int) {
        networkManager.fetchAlbums(forUserId: userId)
            .subscribe(onSuccess: { [weak self] albums in
                self?.albums.accept(albums)
            })
            .disposed(by: disposeBag)
    }
}
