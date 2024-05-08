//
//  NetworkServiceExtension.swift
//  Gallery
//
//  Created by Tamuna Kakhidze on 08.05.24.
//

import Foundation
import NetworkServicePackage

extension NetworkService: ImageFetchingService {
    
    func fetchData(completion: @escaping (Result<[UnsplashPhoto], any Error>) -> (Void)) {
        let urlString = "https://api.unsplash.com/photos/random?count=28&query=formula1&client_id=E5KKnFE7uWbIWG87DZM0lfoBq2-ZFbIHzXV5CikM6Dk"
        NetworkService().getData(urlString: urlString, completion: completion)
    }
    
}
