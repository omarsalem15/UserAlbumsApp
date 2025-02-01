//
//  ViewController.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 01/02/2025.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var albumsTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLargeTitle()

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
        navigationItem.largeTitleDisplayMode = .automatic
    }


}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
        cell.albumNameLabel.text = "Test \(indexPath.row + 1)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

