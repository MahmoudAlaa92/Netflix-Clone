//
//  SearchResultViewController.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 20/06/2024.
//

import UIKit

class SearchResultViewController: UIViewController{
    
    let resultView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width:  UIScreen.main.bounds.width/3 - 10, height: 200)
        
        let collectionView = UICollectionView(frame: .zero ,collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(resultView)
        
        resultView.delegate = self
        resultView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resultView.frame = view.bounds
    }
}

extension SearchResultViewController: UICollectionViewDelegate ,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.backgroundColor = .blue
        return cell
    }
}
