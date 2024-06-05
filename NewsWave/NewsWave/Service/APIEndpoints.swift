//
//  APIEndPoints.swift
//  NewsWave
//
//  Created by Eduardo on 15/05/24.
//

import Foundation

enum APIEndpoints: String {
    case apple = "apple"
    case language = "language=en"
    
    func url() -> String {
        guard let apiKey = fetchAPIKey() else {
            fatalError("API key not found")
        }
        return "\(APIEndpoints.baseURL)\(self.rawValue)&apiKey=\(apiKey)"
    }
    
    private static let baseURL = "https://newsapi.org/v2/top-headlines?"
    
    private func fetchAPIKey() -> String? {
        guard let path = Bundle.main.path(forResource: "apikeys", ofType: "plist"),
              let keys = NSDictionary(contentsOfFile: path),
              let apiKey = keys["API_KEY"] as? String else {
            return nil
        }
        return apiKey
    }
}

