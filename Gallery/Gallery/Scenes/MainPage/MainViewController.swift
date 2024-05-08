//
//  ViewController.swift
//  Gallery
//
//  Created by Tamuna Kakhidze on 08.05.24.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var viewModel = MainViewControllerViewModel()
    
    private typealias DataSourse = UICollectionViewDiffableDataSource<ImagesListSection, UnsplashPhoto>
    private typealias DataSourseSnapshot = NSDiffableDataSourceSnapshot<ImagesListSection, UnsplashPhoto>
    
    private enum ImagesListSection: Int {
        case main
    }
    
    private var dataSource: DataSourse!
    private var snapShot = DataSourseSnapshot()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        viewModel.delegate = self
        view.backgroundColor = .systemBackground
        configureCollectionView()
        viewModel.viewdidload()
        configureCollectionViewDataSource()
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1.5
        layout.minimumInteritemSpacing = 1
        let itemWidth: CGFloat = 124
        let itemHeight: CGFloat = 122
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 77).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    private func configureCollectionViewDataSource() {
        dataSource = DataSourse(collectionView: collectionView!, cellProvider:  { (collectionView,
                                                                                   indexPath, unsplashPhoto) -> CustomCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell?
            cell?.configure(image: unsplashPhoto.urls.small)
            return cell
        })
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: MainViewControllerViewModelDelegate {
    
    func imagesFetched() {
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    func applySnapshot(images: [UnsplashPhoto]) {
        snapShot = DataSourseSnapshot()
        snapShot.appendSections([ImagesListSection.main])
        snapShot.appendItems(images)
        dataSource.apply(snapShot, animatingDifferences: false)
    }
}

