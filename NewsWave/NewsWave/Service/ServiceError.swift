//
//  ServiceError.swift
//  NewsWave
//
//  Created by Eduardo on 16/05/24.
//

import Foundation

enum ServiceError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}
