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
}
