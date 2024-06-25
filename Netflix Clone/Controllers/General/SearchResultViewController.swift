//
//  SearchResultViewController.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 20/06/2024.
//

import UIKit
protocol SearchResultViewControllerDelegate: AnyObject {
    func SearchResultViewControllerDelgate (_ view: TitlePreviewModel)
}
class SearchResultViewController: UIViewController{
    
    weak var delegate: SearchResultViewControllerDelegate?
    
    public var titles:[Titles] = [Titles]()
    
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
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else{
            print("Error in search cell (General)")
            return UICollectionViewCell()
        }
        
        // blue square
        let title = titles[indexPath.row]
        cell.itemsOfTitles(with: title.poster_path ?? "unknown")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = titles[indexPath.row]
        
        CallApi.shared.getMovies(query: title.original_title ?? title.original_name ?? "") { result in
            switch result {
            case .success(let videoElement):
                self.delegate?.SearchResultViewControllerDelgate(TitlePreviewModel(
                    title: title.original_title ?? "",
                    titlOverView: title.overview ?? "",
                    youtubeView: videoElement))
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
