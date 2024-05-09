//
//  MainViewControllerViewModel.swift
//  Gallery
//
//  Created by Tamuna Kakhidze on 08.05.24.
//

import Foundation
import NetworkServicePackage

protocol ImageFetchingService {
    func fetchData(completion: @escaping (Result<[UnsplashPhoto],Error>) ->(Void))
}

protocol MainViewControllerViewModelDelegate: AnyObject {
    func imagesFetched()
    func applySnapshot(images: [UnsplashPhoto])
}

class MainViewControllerViewModel {
    
    var photosArray = [UnsplashPhoto]()
    weak var delegate: MainViewControllerViewModelDelegate?
    private var dataService: ImageFetchingService
    
    init(dataService: ImageFetchingService = NetworkService() as ImageFetchingService) {
        self.dataService = dataService
    }
    
    func viewdidload() {
        dataService.fetchData { [weak self] result in
            switch result {
            case .success(let success):
                self!.photosArray = success
                self?.delegate?.imagesFetched()
                self?.delegate?.applySnapshot(images: success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}

