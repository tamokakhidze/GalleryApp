//
//  FullScreenViewController.swift
//  Gallery
//
//  Created by Tamuna Kakhidze on 08.05.24.
//

import UIKit

class FullScreenViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var viewModel = MainViewControllerViewModel()
    
    private typealias DataSourse = UICollectionViewDiffableDataSource<ImagesListSection, UnsplashPhoto>
    private typealias DataSourseSnapshot = NSDiffableDataSourceSnapshot<ImagesListSection, UnsplashPhoto>
    
    private enum ImagesListSection: Int {
        case main
    }
    
    private var dataSource: DataSourse!
    private var snapShot = DataSourseSnapshot()
    
    var photos: [UnsplashPhoto] = []
    var selectedPhotoIndex: Int = 0
    var selectedPhotoURL: String?
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setup() {
        viewModel.delegate = self
        view.backgroundColor = .systemBackground
        configureCollectionView()
        viewModel.viewdidload()
        configureCollectionViewDataSource()
        setNeedsStatusBarAppearanceUpdate()
        
    }
    
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let itemWidth: CGFloat = view.bounds.width
        let itemHeight: CGFloat = view.bounds.height
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        setConstraints()
        
    }
    
    private func setConstraints() {
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureCollectionViewDataSource() {
        dataSource = DataSourse(collectionView: collectionView!) { (collectionView, indexPath, photoURL) -> CustomCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell
            cell?.configure(image: photoURL.urls.small)
            return cell
        }
    }

}

extension FullScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension FullScreenViewController: UICollectionViewDelegate {
    
}

extension FullScreenViewController: MainViewControllerViewModelDelegate {
    
    func imagesFetched() {}
    
    func applySnapshot(images: [UnsplashPhoto]) {
        snapShot = DataSourseSnapshot()
        snapShot.appendSections([ImagesListSection.main])
        snapShot.appendItems(photos.map { $0 })
        dataSource.apply(snapShot, animatingDifferences: false)
        collectionView?.scrollToItem(at: IndexPath(item: selectedPhotoIndex, section: 0), at: .centeredHorizontally, animated: false)
        collectionView?.isPagingEnabled = true
    }
}

