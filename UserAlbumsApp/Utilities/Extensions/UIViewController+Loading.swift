//
//  UIViewController+Loading.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 03/02/2025.
//

import UIKit

extension UIViewController {
    func showLoadingIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.tag = 100
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        view.viewWithTag(100)?.removeFromSuperview()
    }
    
    func showError(_ error: Error) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}
