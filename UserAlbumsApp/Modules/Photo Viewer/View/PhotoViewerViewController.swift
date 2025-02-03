//
//  PhotoViewerViewController.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 03/02/2025.
//

import UIKit
import SDWebImage

class PhotoViewerViewController: UIViewController {

    var photo: Photo?
    
    private let scrollView = UIScrollView()
    private let photoImageView = UIImageView()
    private let shareButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        photoImageView.contentMode = .scaleAspectFit
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(photoImageView)
        
        shareButton.setTitle("Share", for: .normal)
        shareButton.tintColor = .white
        shareButton.backgroundColor = .systemBlue
        shareButton.layer.cornerRadius = 8
        shareButton.addTarget(self, action: #selector(sharePhoto), for: .touchUpInside)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(shareButton)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            photoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            photoImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            photoImageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shareButton.widthAnchor.constraint(equalToConstant: 100),
            shareButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configure(with photo: Photo) {
            //    if let url = photo.url {
            //        photoImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            //    } else {
            //        photoImageView.image = UIImage(named: "placeholder")
            //    }
        
        let appleImage = URL(string: "https://thetownofcicero.com/wp-content/uploads/2020/11/600x600.png")
        photoImageView.sd_setImage(with: appleImage, placeholderImage: UIImage(systemName: "magnifyingglass"))
        
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    @objc private func sharePhoto() {
        guard let image = photoImageView.image else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}
extension PhotoViewerViewController: UIScrollViewDelegate {
}
