//
//  ViewController.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 01/02/2025.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var albumsTableView: UITableView!
    
    let randomUserId = 1
    private let viewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLargeTitle()
        setupBindings()
        viewModel.fetchUser(userId: randomUserId)
        viewModel.fetchAlbums(userId: randomUserId)
    }
    
    private func setupTableView() {
        albumsTableView.delegate = self
        albumsTableView.dataSource = self
        albumsTableView.separatorStyle = .singleLine
        albumsTableView.register(AlbumTableViewCell.nib(), forCellReuseIdentifier: AlbumTableViewCell.identifier)
        albumsTableView.showsVerticalScrollIndicator = false
    }
    
    private func setupLargeTitle() {
        self.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupBindings() {
        viewModel.user
            .subscribe(onNext: { [weak self] user in
                self?.usernameLabel.text = user?.name
                self?.addressLabel.text = user?.address.fullAddress
            })
            .disposed(by: disposeBag)
        
        viewModel.albums
            .subscribe(onNext: { [weak self] album in
                self?.albumsTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    private func navigateToAlbumDetails(album: Album) {
        let albumDetailsViewController = AlbumDetailsViewController()
        albumDetailsViewController.albumId = album.id
        albumDetailsViewController.albumTitle = album.title
        navigationController?.pushViewController(albumDetailsViewController, animated: true)
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albums.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        let album = viewModel.albums.value[indexPath.row]
        cell.albumNameLabel.text = album.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = viewModel.albums.value[indexPath.row]
        navigateToAlbumDetails(album: album)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

