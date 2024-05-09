//
//  CollectionViewConfiguration.swift
//  Gallery
//
//  Created by Tamuna Kakhidze on 09.05.24.
//

import Foundation
import UIKit

func configureCollectionView(view: UIView, itemWidth: CGFloat, itemHeight: CGFloat, lineSpacing: CGFloat, itemSpacing: CGFloat, scrollDirection: UICollectionView.ScrollDirection) -> UICollectionView {
    var collectionView: UICollectionView?
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = scrollDirection
    layout.minimumLineSpacing = lineSpacing
    layout.minimumInteritemSpacing = itemSpacing
    
    let itemWidth = itemWidth
    let itemHeight = itemHeight
    layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    guard let collectionView = collectionView else { return UICollectionView() }
    
    collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.identifier)
    
    collectionView.backgroundColor = .clear
    
    view.addSubview(collectionView)
    
    setConstraintsForCollectionView(collectionView: collectionView, view: view)
    
    return collectionView
}

func setConstraintsForCollectionView(collectionView: UICollectionView, view: UIView) {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 77).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
}

