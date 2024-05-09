//
//  NetworkServiceExtension.swift
//  Gallery
//
//  Created by Tamuna Kakhidze on 08.05.24.
//

import Foundation
import NetworkServicePackage

// MARK: - Fetching data extension

extension NetworkService: ImageFetchingService {
    
    func fetchData(completion: @escaping (Result<[UnsplashPhoto], any Error>) -> (Void)) {
        let accessKey = "jw798kHPyACrBFUfIEZGd1wEqg61WC_5eoAGmVpdI6E"
        let urlString = "https://api.unsplash.com/photos/random?count=60&query=filmphotography&client_id=\(accessKey)"
        NetworkService().getData(urlString: urlString, completion: completion)
    }
    
}
