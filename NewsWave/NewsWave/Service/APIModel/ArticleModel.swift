//
//  APIModel.swift
//  NewsWave
//
//  Created by Eduardo on 15/05/24.
//

import Foundation
import UIKit

protocol Filterable: Codable {
    mutating func filter()
}

struct Article: Codable {
    
    struct Source: Codable {
        let id: String?
        let name: String
    }
    
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: URL
    let urlToImage: URL?
    let publishedAt: Date
    let content: String?
}

struct ApiResponse: Filterable {
    let status: String
    let totalResults: Int
    var articles: [Article]
    
    mutating func filter() {
        articles.removeAll { $0.source.name == "[Removed]" }
    }
}

