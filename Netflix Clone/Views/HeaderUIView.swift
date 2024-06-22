//
//  HomeHeaderUIView.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 14/06/2024.
//

import UIKit


class HeaderUIView: UIView {
    
    private let HeaderImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "HomeHeaderImage")
        image.clipsToBounds = true
        return image
    }()
    
    private let playButton: UIButton = {
        let playButton = UIButton()
        
        playButton.setTitle("Play", for: .normal)
        playButton.layer.cornerRadius = 6
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor.white.cgColor
        return playButton
    }()
    
    private let downloudButton = {
        let playButton = UIButton()
        playButton.setTitle("Downloud", for: .normal)
        playButton.layer.cornerRadius = 6
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    }()
    
    private func addGrdient(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        layer.addSublayer(gradientLayer)
    }
    
    func configure(with model: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model ?? "")") else {
            print("Error 404")
            return
        }
        HeaderImage.sd_setImage(with: url, completed: nil)
    }
    
    public func changeImageOfHeader(with model: [Titles]){
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(HeaderImage)
        addGrdient()
        addSubview(playButton)
        addSubview(downloudButton)
        addconstrian()
    }
    
    override func layoutSubviews() {
        HeaderImage.frame = bounds
    }
    
    func addconstrian(){
        let playButtonConstrian = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 95),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: frame.width/4.5+10),
            playButton.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        let downloudbuttonConstrian = [
            downloudButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -95),
            downloudButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloudButton.widthAnchor.constraint(equalToConstant: frame.width/4.5+10),
            downloudButton.heightAnchor.constraint(equalToConstant: 30)
            
        ]
        
        NSLayoutConstraint.activate(playButtonConstrian)
        NSLayoutConstraint.activate(downloudbuttonConstrian)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
