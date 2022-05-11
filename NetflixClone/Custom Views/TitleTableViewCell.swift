//
//  TitleTableViewCell.swift
//  NetflixClone
//
//  Created by Gustavo Colaço on 08/05/22.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureCellUI() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(playTitleButton)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            
            playTitleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playTitleButton.widthAnchor.constraint(equalToConstant: 40),
            playTitleButton.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: playTitleButton.leadingAnchor, constant: -8),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            

            
        ])
    }
    
    
    func setData(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else { return }
        posterImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }
    

}
