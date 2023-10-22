//
//  ApiServices.swift
//  Berita Indo CNN
//
//  Created by Sultan Rifaldy on 22/10/23.
//

import Foundation
import Alamofire

class ApiServices {
    static let shared: ApiServices = ApiServices()
    private init () {}
    
    private let API = "https://berita-indo-api-next.vercel.app/api/cnn-news/"
    
    func loadNews(completion: @escaping (Result<[News], Error>)-> Void) {
        let urlString = API
        AF.request(urlString, method: HTTPMethod.get)
            .validate()
            .responseDecodable (of: NewsResponse.self){ response in
                switch response.result {
                case .success(let newsArticle):
                    completion(.success(newsArticle.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
