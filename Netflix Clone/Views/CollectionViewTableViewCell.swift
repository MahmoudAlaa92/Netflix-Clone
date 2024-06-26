//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 13/06/2024.
//

import UIKit

protocol DataSharingDelegate: AnyObject {
    func didRecieveData(_ data: TitlePreviewModel)
}

class CollectionViewTableViewCell: UITableViewCell {

    weak var delegate: DataSharingDelegate?
    
    static let identifier = "CollectionViewTableViewCell"
    private var titles: [Titles] = [Titles]()
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero ,collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    override func layoutSubviews() {
        collectionView.frame = contentView.bounds
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   public func itemsOfTitles(with titles: [Titles]){
       self.titles = titles
       DispatchQueue.main.async{ [weak self] in
           self?.collectionView.reloadData()
       }
    }
    
//        saveDataToDownloudPage
    private func downloudTitleAt (indexPath: IndexPath){
        DataPersistentManager.shared.creatData(with: titles[indexPath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("Downlouded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDataSource ,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else{
            print("Error when convert to titleCollectionViewCell")
            return UICollectionViewCell()
        }
        
        guard let model = titles[indexPath.row].poster_path else{
            print("Error when put a value in model ")
            return cell
        }
        cell.itemsOfTitles(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_title ?? title.original_name else{
            return
        }

        CallApi.shared.getMovies(query: titleName + " trailer") { [weak self] result in
            switch result {
                
            case .success(let Answer):
                self?.delegate?.didRecieveData(TitlePreviewModel(title: titleName, titlOverView: title.overview ?? "", youtubeView: Answer))
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) { _ in
                let downloudAction = UIAction(
                    title: "Downloud",
                    image: nil,
                    identifier: nil,
                    discoverabilityTitle: nil,
                    state: .off) { _ in
                        self.downloudTitleAt(indexPath: indexPath)
                    }
                return UIMenu(
                    title: "",
                    image: nil,
                    identifier: nil,
                    children: [downloudAction])
            }
        return config
    }
}
