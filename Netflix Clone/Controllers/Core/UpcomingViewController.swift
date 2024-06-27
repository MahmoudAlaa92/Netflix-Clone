//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 13/06/2024.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var titles: [Titles] = [Titles]()
    
    private let upComingMoviesTable: UITableView = {
        let table = UITableView();
        table.register(UpComingTableViewCell.self, forCellReuseIdentifier: UpComingTableViewCell.identifier)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "UP Coming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upComingMoviesTable)
        upComingMoviesTable.delegate = self
        upComingMoviesTable.dataSource = self
        fetchDataForTitles()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upComingMoviesTable.frame = view.bounds
    }
    
    func fetchDataForTitles(){
        CallApi.shared.upComingMovies { result in
            switch result {
            case .success(let titles):
                self.titles = titles
            case .failure(let Error):
                print(Error)
            }
        }
    }
}

extension UpcomingViewController: UITableViewDelegate ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         titles.count
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
