//
//  SearchViewController.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 13/06/2024.
//

import UIKit

class SearchViewController: UIViewController {
    private var titles: [Titles] = [Titles]()

    private let searchTableView: UITableView = {
        let table = UITableView();
        table.register(UpComingTableViewCell.self, forCellReuseIdentifier: UpComingTableViewCell.identifier)
        
        return table
    }()
    
    private let searchResult: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultViewController())
        search.searchBar.placeholder = "Search For a Movies"
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchResult
        navigationController?.navigationBar.tintColor = .white
        
        view.addSubview(searchTableView)
        view.addSubview(searchTableView)
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        fetchDataSearchTable()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTableView.frame = view.bounds
    }
    
    func fetchDataSearchTable(){
        CallApi.shared.getSearch { result in
            switch result {
            case .success(let titles):
                self.titles = titles
            case .failure(let Error):
                print(Error)
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpComingTableViewCell.identifier, for: indexPath) as? UpComingTableViewCell else{
            print("Error when Convert cell to UpcomingViewCell")
            return UITableViewCell()
        }
        
        let title =  titles[indexPath.row]
        cell.itemsOfUpcoming(with: TitleViewCell(
            posterUrl: title.poster_path ?? "Unknown",
            titleName: title.original_title ?? title.original_name ?? "un known"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.size.height/5
    }
}
