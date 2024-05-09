//
//  FullScreenViewController.swift
//  Gallery
//
//  Created by Tamuna Kakhidze on 08.05.24.
//

import UIKit

final class FullScreenViewController: UIViewController {
    
    // MARK: - Properties and UI components
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
       
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        viewModel.delegate = self
        view.backgroundColor = .systemBackground
        //configureCollectionView()
        collectionView = configureCollectionView(view: view, itemWidth: view.bounds.width, itemHeight: view.bounds.height, lineSpacing: 0, itemSpacing: 0, scrollDirection: .horizontal)
        collectionView!.delegate = self
        viewModel.viewdidload()
        configureCollectionViewDataSource()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // MARK: - DataSource configuration
    private func configureCollectionViewDataSource() {
        dataSource = DataSourse(collectionView: collectionView!) { (collectionView, indexPath, photoURL) -> CustomCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell
            cell!.isFullScreen = true
            cell?.configure(image: photoURL.urls.small)
            return cell
        }
    }

}

// MARK: - FullScreenVC extensions
extension FullScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension FullScreenViewController: UICollectionViewDelegate {
    
}

extension FullScreenViewController: MainViewControllerViewModelDelegate {
        
    func applySnapshot(images: [UnsplashPhoto]) {
        snapShot = DataSourseSnapshot()
        snapShot.appendSections([ImagesListSection.main])
        snapShot.appendItems(photos.map { $0 })
        dataSource.apply(snapShot, animatingDifferences: false)
        collectionView?.scrollToItem(at: IndexPath(item: selectedPhotoIndex, section: 0), at: .centeredHorizontally, animated: false)
        collectionView?.isPagingEnabled = true
    }
}

