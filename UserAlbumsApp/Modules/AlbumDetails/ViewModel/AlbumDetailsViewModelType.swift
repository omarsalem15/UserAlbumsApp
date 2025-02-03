//
//  AlbumDetailsViewModelType.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 03/02/2025.
//

import Foundation
import RxRelay
import RxSwift

protocol AlbumDetailsViewModelType {
    var photos: BehaviorRelay<[Photo]> { get }
    var filteredPhotos: BehaviorRelay<[Photo]> { get }
    var isLoading: BehaviorRelay<Bool> { get }
    var error: PublishSubject<Error> { get }
    
    func fetchPhotos(albumId: Int)
    func filterPhotos(by query: String)
}
