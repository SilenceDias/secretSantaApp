//
//  ApiResult.swift
//  SecretSanta
//
//  Created by Диас Мухамедрахимов on 06.04.2024.
//

import Foundation

enum APIResult<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError {
    case networkFail
    case incorrectJson
    case unknown
    case failedWith(error: String)
}
