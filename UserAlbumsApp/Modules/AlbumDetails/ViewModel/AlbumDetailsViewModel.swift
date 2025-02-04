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

class AlbumDetailsViewModel:AlbumDetailsViewModelType {
    private let networkManager : NetworkManagerType
    private let disposeBag = DisposeBag()
    
    let photos = BehaviorRelay<[Photo]>(value: [])
    let filteredPhotos = BehaviorRelay<[Photo]>(value: [])
    let isLoading = BehaviorRelay<Bool>(value: false)
    let error = PublishSubject<Error>()
    
    init(networkManager: NetworkManagerType = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchPhotos(albumId: Int) {
        isLoading.accept(true)
        networkManager.fetchPhotos(albumId: albumId)
            .subscribe(onSuccess: { [weak self] photos in
                self?.isLoading.accept(false)
                let photoUIModels = photos.map { Photo(from: $0) }
                self?.photos.accept(photoUIModels)
                self?.filteredPhotos.accept(photoUIModels)
            }, onError: { [weak self] networkError in
                self?.isLoading.accept(false)
                self?.error.onNext(AppError.networkError(networkError))
            })
            .disposed(by: disposeBag)
    }
    
    func filterPhotos(by query: String) {
        let trimmedQuery = query.replacingOccurrences(of: " ", with: "").lowercased()
        
        if trimmedQuery.isEmpty {
            filteredPhotos.accept(photos.value)
        } else {
            let filtered = photos.value.filter {
                $0.title.replacingOccurrences(of: " ", with: "").lowercased().contains(trimmedQuery)
            }
            filteredPhotos.accept(filtered)
        }
    }
}
