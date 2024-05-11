//
//  ViewController.swift
//  Gallery
//
//  Created by Tamuna Kakhidze on 08.05.24.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Properties and UI components
    private var collectionView: UICollectionView?
    private var viewModel = MainViewControllerViewModel()
    
    private typealias DataSource = UICollectionViewDiffableDataSource<ImagesListSection, UnsplashPhoto>
    private typealias DataSourseSnapshot = NSDiffableDataSourceSnapshot<ImagesListSection, UnsplashPhoto>
    
    private enum ImagesListSection: Int {
        case main
    }
    
    private var dataSource: DataSource!
    private var snapShot = DataSourseSnapshot()
    
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
        collectionView = configureCollectionView(view: view, itemWidth: 124, itemHeight: 122, lineSpacing: 1.5, itemSpacing: 1, scrollDirection: .vertical)
        collectionView!.delegate = self
        viewModel.viewdidload()
        configureCollectionViewDataSource()
        configureTitle()
    }
    
    private func configureTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        let titleLabel = UILabel()
        titleLabel.text = "Photos"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.sizeToFit()
        title = ""
        navigationController?.navigationBar.tintColor = .black
        navigationItem.titleView = titleLabel
    }
    
    // MARK: - Diffable DataSource configuration
    private func configureCollectionViewDataSource() {
        dataSource = DataSource(collectionView: collectionView!, cellProvider:  { (collectionView,
                                                                                   indexPath, unsplashPhoto) -> CustomCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.identifier, for: indexPath) as! CustomCell?
            cell?.configure(image: self.viewModel.photosArray[indexPath.row].urls.small)
            return cell
        })
    }
    
}
// MARK: - MainVC Extensions
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPhotosURLs = viewModel.photosArray
        
        let fullScreenVC = FullScreenViewController()
        fullScreenVC.photos = selectedPhotosURLs
        fullScreenVC.selectedPhotoIndex = indexPath
        
        navigationController?.pushViewController(fullScreenVC, animated: true)
    }
}

extension MainViewController: MainViewControllerViewModelDelegate {
    
    func imagesFetched() {
        DispatchQueue.main.async {
            self.applySnapshot(images: self.viewModel.photosArray)
        }
    }
    
    func applySnapshot(images: [UnsplashPhoto]) {
        snapShot = DataSourseSnapshot()
        snapShot.appendSections([ImagesListSection.main])
        snapShot.appendItems(images)
        dataSource.apply(snapShot, animatingDifferences: false)
    }
    
//    func navigateToFullScreen(selectedPhotosURLs: [UnsplashPhoto], index: Int) {
//        let fullScreenVC = FullScreenViewController()
//        fullScreenVC.photos = selectedPhotosURLs
//        fullScreenVC.selectedPhotoIndex = index
//        
//        navigationController?.pushViewController(fullScreenVC, animated: true)
//    }
    
}

