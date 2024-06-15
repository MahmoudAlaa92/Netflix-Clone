//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 13/06/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero,style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configerNavbar()
        
        let headeView = HomeHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 435))
        homeFeedTable.tableHeaderView = headeView
    }
    
    func configerNavbar(){
        
        var image = UIImage(named: "netflixLogo")
        

        image = image?.withRenderingMode(.alwaysOriginal)
        
        
        let leftBarButton = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        let leftDisplacement = (view.bounds.width / 5) - 30
        leftBarButton.imageInsets = UIEdgeInsets(top: 0, left: -leftDisplacement, bottom: 0, right: 0)
        navigationItem.leftBarButtonItem = leftBarButton
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let safeArea = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + safeArea
        print(offset)
        navigationController?.navigationBar.transform = .init(translationX: 0, y: -offset)
    }
}

extension HomeViewController: UITableViewDelegate ,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as?  CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
