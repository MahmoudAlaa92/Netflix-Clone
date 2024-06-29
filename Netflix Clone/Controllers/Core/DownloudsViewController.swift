//
//  DownloudViewController.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 13/06/2024.
//

import UIKit

class DownloudViewController: UIViewController {
    
    var titleItem: [TitleItem] = [TitleItem]()
    
    private let downloudTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UpComingTableViewCell.self, forCellReuseIdentifier: UpComingTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Downloud"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(downloudTableView)
        downloudTableView.delegate = self
        downloudTableView.dataSource = self
        fetchData()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Downlouded"), object: nil, queue: nil) { _ in
            self.fetchData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloudTableView.frame = view.bounds
        
    }
    
    func fetchData(){
        DataPersistentManager.shared.fetchData { [weak self] result in
            switch result {
            case .success(let TitleItem):
                DispatchQueue.main.async {
                    self?.titleItem = TitleItem
                    self?.downloudTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension DownloudViewController: UITableViewDataSource ,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titleItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UpComingTableViewCell.identifier, for: indexPath) as? UpComingTableViewCell else {
            return UpComingTableViewCell()
        }
        let title = titleItem[indexPath.row]
        cell.itemsOfUpcoming(with:
                                TitleViewCell(
                                    posterUrl: title.poster_path,
                                    titleName: title.original_title ?? title.original_name ?? ""
                                ))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.size.height/5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let title = titleItem[indexPath.row]
        
        CallApi.shared.getMovies(query: title.original_title ?? title.original_name ?? "" + " Trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                let title = self?.titleItem[indexPath.row]
                
                DispatchQueue.main.async {
                    
                    let vc = TitlePreviewViewController()
                    vc.didRecieveData(TitlePreviewModel(
                        title: title?.original_title ?? title?.original_name ?? "",
                        titlOverView: title?.overview ?? "",
                        youtubeView: videoElement
                    ))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        DataPersistentManager.shared.deleteData(with: titleItem[indexPath.row]) { [weak self] result in
            switch editingStyle {
            case .delete:
                switch result {
                case .success(()):
                    print("deleted Completed")
                    self?.titleItem.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            default:
                break
            }
        }
    }
}
