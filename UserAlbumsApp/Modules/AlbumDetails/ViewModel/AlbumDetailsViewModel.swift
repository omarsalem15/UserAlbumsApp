//
//  AlbumDetailsViewModel.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 02/02/2025.
//



import Foundation
import RxSwift
import RxRelay
import RxCocoa

class AlbumDetailsViewModel {
    private let networkManager = NetworkManager.shared
    private let disposeBag = DisposeBag()
    
    let photos = BehaviorRelay<[Photo]>(value: [])
    let filteredPhotos = BehaviorRelay<[Photo]>(value: [])
    
    func fetchPhotos(albumId: Int) {
        networkManager.fetchPhotos(albumId: albumId)
            .subscribe(onSuccess: { [weak self] photos in
                let photoUIModels = photos.map { Photo(from: $0) }
                self?.photos.accept(photoUIModels)
                self?.filteredPhotos.accept(photoUIModels)
            }, onError: { [weak self] error in
            })
            .disposed(by: disposeBag)
    }
    
    func filterPhotos(by query: String) {
        if query.isEmpty {
            filteredPhotos.accept(photos.value)
        } else {
            let filtered = photos.value.filter { $0.title.lowercased().contains(query.lowercased()) }
            filteredPhotos.accept(filtered)
        }
    }
}
