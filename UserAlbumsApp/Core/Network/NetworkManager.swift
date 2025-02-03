//
//  NetworkManager.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 01/02/2025.
//

import Moya
import RxSwift
import RxMoya

class NetworkManager: NetworkManagerType {
    static let shared = NetworkManager()
    private let provider: MoyaProvider<API>
    
    private init() {
        self.provider = MoyaProvider<API>(plugins: [loggerPlugin])
    }
    
    private let loggerPlugin = NetworkLoggerPlugin(configuration: .init(
        formatter: .init(),
        output: { (target, items) in
            for item in items {
                print("\(item)")
            }
        },
        logOptions: .verbose
    ))
    
    func fetchUsers() -> Single<[UserResponse]> {
        return provider.rx.request(.users)
            .filterSuccessfulStatusCodes()
            .map([UserResponse].self)
    }
    
    func fetchAlbums(forUserId userId: Int) -> Single<[Album]> {
        return provider.rx.request(.albums(userId: userId))
            .filterSuccessfulStatusCodes()
            .map([Album].self)
    }
    
    func fetchPhotos(albumId: Int) -> Single<[PhotoResponse]> {
        return provider.rx.request(.photos(albumId: albumId))
            .filterSuccessfulStatusCodes()
            .map([PhotoResponse].self)
    }
}
