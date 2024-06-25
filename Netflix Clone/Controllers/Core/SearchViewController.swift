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
    
    private var searchResult: UISearchController = {
        let search = UISearchController(searchResultsController: SearchResultViewController())
        search.searchBar.placeholder = "Search For a Movies"
        search.searchBar.searchTextField.layer.cornerRadius = 15
        search.searchBar.searchTextField.layer.masksToBounds = true
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
        
        searchResult.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTableView.frame = view.bounds
    }
    
    func fetchDataSearchTable(){
        CallApi.shared.getDiscoverMovies { result in
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        CallApi.shared.getMovies(query: title.original_title ?? "") { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.didRecieveData(
                        TitlePreviewModel(title: title.original_title ?? "",
                                          titlOverView: title.overview ?? "",
                                          youtubeView: videoElement))
                    
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating ,SearchResultViewControllerDelegate{
    func SearchResultViewControllerDelgate(_ view: TitlePreviewModel) {
       
        
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.didRecieveData(TitlePreviewModel(title: view.title, titlOverView: view.titlOverView, youtubeView: view.youtubeView))
            
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchResult.searchBar
        guard let query = searchBar.text
                ,query.trimmingCharacters(in: .whitespaces).count > 2 ,let resultController = searchResult.searchResultsController as? SearchResultViewController else {
            return
        }
        resultController.delegate = self
        CallApi.shared.search(query: query) { result in
            switch result {
            case .success(let titles):
                DispatchQueue.main.async {
                    resultController.titles = titles
                    resultController.resultView.reloadData()
                }
            case .failure(let error):
                print("Error in searchAPI Caller (search query): \(error)")
            }
        }

    }
}
