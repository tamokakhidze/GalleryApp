//
//  ImageViewExtension.swift
//  Gallery
//
//  Created by Tamuna Kakhidze on 08.05.24.
//

import UIKit
// MARK: - Set image extension
extension UIImageView {
    func setImage(with url: URL) {
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
