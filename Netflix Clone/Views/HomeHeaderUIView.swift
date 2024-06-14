//
//  HomeHeaderUIView.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 14/06/2024.
//

import UIKit

class HomeHeaderUIView: UIView {
 
    private let HeaderImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "HomeHeaderImage2")
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
        playButton.widthAnchor.constraint(equalToConstant: frame.width/4.5),
        playButton.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        let downloudbuttonConstrian = [
            downloudButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -95),
            downloudButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloudButton.widthAnchor.constraint(equalToConstant: frame.width/4.5),
            downloudButton.heightAnchor.constraint(equalToConstant: 30)
        
        ]
        
        NSLayoutConstraint.activate(playButtonConstrian)
        NSLayoutConstraint.activate(downloudbuttonConstrian)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
