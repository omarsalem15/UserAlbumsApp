//
//  AlbumDetailsViewController.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 02/02/2025.
//

import UIKit
import RxSwift

class AlbumDetailsViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var noResultLabel: UILabel!
    
    var albumId: Int = 0
    var albumTitle: String = ""
    private let viewModel: AlbumDetailsViewModelType
    private let disposeBag = DisposeBag()
    
    init(viewModel: AlbumDetailsViewModelType = AlbumDetailsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupLargeTitle()
        setupSearchBar()
        setupBindings()
        viewModel.fetchPhotos(albumId: albumId)
    }
    
    private func setupCollectionView() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        photosCollectionView.register(PhotoCollectionViewCell.nib(), forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        photosCollectionView.showsVerticalScrollIndicator = false
        noResultLabel.isHidden = true
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search in images.."
    }
    
    private func setupLargeTitle() {
        title = "\(albumTitle)"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    private func setupBindings() {
        
        viewModel.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? self?.showLoadingIndicator() : self?.hideLoadingIndicator()
            })
            .disposed(by: disposeBag)
        
        viewModel.error
            .subscribe(onNext: { [weak self] error in
                self?.showError(error)
            })
            .disposed(by: disposeBag)
        
        viewModel.filteredPhotos
            .subscribe(onNext: { [weak self] _ in
                self?.photosCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] query in
                self?.viewModel.filterPhotos(by: query)
                self?.noResultLabel.isHidden = !(self?.viewModel.filteredPhotos.value.isEmpty ?? true)
                self?.photosCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func navigateToPhotoViewer(for photo: Photo) {
        let photoViewerVC = PhotoViewerViewController()
        photoViewerVC.configure(with: photo)
        navigationController?.pushViewController(photoViewerVC, animated: true)
    }
}

extension AlbumDetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredPhotos.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        let photo = viewModel.filteredPhotos.value[indexPath.row]
        cell.configure(with: photo)
        return cell
    }
}

extension AlbumDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width ) / 3
        return CGSize(width: width, height: width)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = viewModel.filteredPhotos.value[indexPath.row]
        navigateToPhotoViewer(for: photo)
    }

}

extension AlbumDetailsViewController: UISearchBarDelegate  {
    
}
