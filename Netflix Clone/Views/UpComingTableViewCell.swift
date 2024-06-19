//
//  UpComingTableViewCell.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 19/06/2024.
//

import UIKit

class UpComingTableViewCell: UITableViewCell {

    static let identifier = "UpComingTableViewCell"
    
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let labelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    private let playButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(posterImage)
        contentView.addSubview(labelView)
        contentView.addSubview(playButton)
        applyConstrain()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func applyConstrain() {
        let posterImageConstrain = [
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImage.widthAnchor.constraint(equalToConstant: contentView.frame.size.width/2),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            posterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ]
        
        let labelViewConstrain = [
            labelView.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor,constant: 10),
            labelView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        
         let playButtonConstraints = [
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playButton.widthAnchor.constraint(equalToConstant: 40)
         ]
         
        NSLayoutConstraint.activate(posterImageConstrain)
        NSLayoutConstraint.activate(labelViewConstrain)
        NSLayoutConstraint.activate(playButtonConstraints)
    }
    
    public func itemsOfUpcoming (with model: TitleViewCell){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterUrl!)") else{
            print("Error when convert model to url for UpcomingMovies")
            return
        }
        posterImage.sd_setImage(with: url)
        labelView.text = model.titleName
    }
}
