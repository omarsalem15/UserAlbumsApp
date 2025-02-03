//
//  Error + Extensions.swift
//  UserAlbumsApp
//
//  Created by Omar Salem on 03/02/2025.
//

import Foundation

enum AppError: Error {
    case networkError(Error)
    case parsingError
    case unknownError
    
    var localizedDescription: String {
        switch self {
            case .networkError(let error):
                return "Network Error: \(error.localizedDescription)"
            case .parsingError:
                return "Unable to parse data"
            case .unknownError:
                return "Unknown error"
        }
    }
}

protocol LoadingIndicatorType {
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

protocol ErrorHandlingType {
    func showError(_ error: Error)
}
