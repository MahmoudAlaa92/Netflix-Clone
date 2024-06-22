//
//  TitlePreviewViewController.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 22/06/2024.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    private var webView: WKWebView = {
        let webView = WKWebView()
        webView.backgroundColor = .white
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }()
    
    private var titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0;
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    private var overView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0;
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        
        return label
    }()
    
    private var downloudBtn: UIButton = {
        let downloudBtn = UIButton()
        downloudBtn.translatesAutoresizingMaskIntoConstraints = false
        downloudBtn.backgroundColor = .red
        downloudBtn.setTitle("Downloud", for: .normal)
        downloudBtn.setTitleColor(.white, for: .normal)
        downloudBtn.layer.cornerRadius = 7
        downloudBtn.layer.masksToBounds = true
        
        return downloudBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleView)
        view.addSubview(overView)
        view.addSubview(downloudBtn)
        
        applyConstrain()
    }
    
    func applyConstrain(){
        let webViewConstrain = [
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor ,constant: 55),
            webView.heightAnchor.constraint(equalToConstant: view.bounds.size.height/3)
            
        ]
        
        let titleViewConstrain = [
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor ,constant: 20),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
        ]
        
        let overViewConstrain = [
            overView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20),
        ]
        
        let downloudBtnConstrain = [
            downloudBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            downloudBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            downloudBtn.topAnchor.constraint(equalTo: overView.bottomAnchor, constant: 20),
            downloudBtn.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webViewConstrain)
        NSLayoutConstraint.activate(titleViewConstrain)
        NSLayoutConstraint.activate(overViewConstrain)
        NSLayoutConstraint.activate(downloudBtnConstrain)
    }
    
    func didRecieveData(_ data: TitlePreviewModel) {
        titleView.text = data.title
        overView.text = data.titlOverView
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(data.youtubeView.id.videoId ?? "")") else{
            print("Error when Convert URL For webView")
            return
        }
        webView.load(URLRequest(url: url))
    }
}
