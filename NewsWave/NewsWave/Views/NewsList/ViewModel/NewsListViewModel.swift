//
//  NewsListViewModel.swift
//  NewsWave
//
//  Created by Eduardo on 15/05/24.
//

import Foundation
import UIKit

class NewsListViewModel {
    private let serviceManager: ServiceManager
    var model: NewsListModel
    
    init(serviceManager: ServiceManager) {
        self.serviceManager = serviceManager
        self.model = NewsListModel()
        self.model.image = []  // Initialize the image array
    }
    
    func fetchData(completion: @escaping () -> Void) {
        Task {
            if let apiResults: ApiResponse = await serviceManager.downloadAndFilterData() {
                model.articles = apiResults.articles
                model.image = Array(repeating: UIImage(systemName: "photo")!, count: model.articles.count) // Match the image array with articles
                completion()
            }
        }
    }
    
    func downloadImage(for index: Int, completion: @escaping () -> Void) {
        let article = model.articles[index]
        guard let imageUrl = article.urlToImage else {
            completion()
            return
        }
        
        serviceManager.downloadImage(from: imageUrl) { [weak self] image in
            self?.model.image[index] = image ?? UIImage(systemName: "photo")!
            completion()
        }
    }
    
    func numberOfArticles() -> Int {
        return model.articles.count
    }
    
    func article(at index: Int) -> Article {
        return model.articles[index]
    }
}

