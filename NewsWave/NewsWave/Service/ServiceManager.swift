//
//  ServiceManager.swift
//  NewsWave
//
//  Created by Eduardo on 15/05/24.
//


import Foundation
import UIKit

class ServiceManager {
    
    func downloadData<T: Codable>(url: String = APIEndpoints.language.url()) async -> T? {
        do {
            guard let url = URL(string: url) else { throw ServiceError.badUrl }
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else { throw ServiceError.badResponse }
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw ServiceError.badStatus }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            guard let decodedResponse = try? decoder.decode(T.self, from: data) else { throw ServiceError.failedToDecodeResponse }
            return decodedResponse
        } catch ServiceError.badUrl {
            print("There was an error creating the URL")
        } catch ServiceError.badResponse {
            print("Did not get a valid response")
        } catch ServiceError.badStatus {
            print("Did not get a 2xx status code from the response")
        } catch ServiceError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("An error occured downloading the data")
        }
        return nil
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }

    func downloadAndFilterData<T: Filterable>() async -> T? {
        // Attempt to download data and check if the response is of type T
        if var response: T = await downloadData() {
            // Apply the filtering method defined in the Filterable protocol
            response.filter()
            
            return response
        }
        // Return nil if the above condition fails
        return nil
    }
}



// api results
//{
//"status": "ok",
//"totalResults": 12836,
//-"articles": [
//-{
//-"source": {
//"id": "wired",
//"name": "Wired"
//},
//"author": "Andy Greenberg",
//"title": "A Vast New Dataset Could Supercharge the AI Hunt for Crypto Money Laundering",
//"description": "Blockchain analysis firm Elliptic, MIT, and IBM, have released a new AI detection model—and the 200-million-transaction dataset it's trained on—that aims to spot the “shape” of Bitcoin money laundering.",
//"url": "https://www.wired.com/story/ai-crypto-tracing-model-money-laundering/",
//"urlToImage": "https://media.wired.com/photos/6631a1936dc0c77846852ed5/191:100/w_1280,c_limit/Crypto-Money-Laundering-Security-GettyImages-1543076825.jpg",
//"publishedAt": "2024-05-01T13:00:00Z",
//"content": "As a test of their resulting AI tool, the researchers checked its outputs with one cryptocurrency exchangewhich the paper doesn't nameidentifying 52 suspicious chains of transactions that had all ult… [+3279 chars]"
//},
