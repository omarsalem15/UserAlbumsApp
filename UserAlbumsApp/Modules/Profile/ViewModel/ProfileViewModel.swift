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

class ProfileViewModel: ProfileViewModelType {
    private let networkManager: NetworkManagerType
    private let disposeBag = DisposeBag()
    
    let user = BehaviorRelay<User?>(value: nil)
    let albums = BehaviorRelay<[Album]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    let error = PublishSubject<Error>()
    
    init(networkManager: NetworkManagerType = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchUser(userId: Int) {
        isLoading.accept(true)
        networkManager.fetchUsers()
            .subscribe(onSuccess: { [weak self] users in
                self?.isLoading.accept(false)
                guard userId <= users.count else {
                    self?.error.onNext(AppError.unknownError)
                    return
                }
                let user = users[userId-1]
                let userUIModel = User(from: user)
                self?.user.accept(userUIModel)
            }, onError: { [weak self] networkError in
                self?.isLoading.accept(false)
                self?.error.onNext(AppError.networkError(networkError))
            })
            .disposed(by: disposeBag)
    }
    
    func fetchAlbums(userId: Int) {
        isLoading.accept(true)
        networkManager.fetchAlbums(forUserId: userId)
            .subscribe(onSuccess: { [weak self] albums in
                self?.isLoading.accept(false)
                self?.albums.accept(albums)
            }, onError: { [weak self] networkError in
                self?.isLoading.accept(false)
                self?.error.onNext(AppError.networkError(networkError))
            })
            .disposed(by: disposeBag)
    }
}
