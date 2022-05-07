//
//  CollectionViewTableViewCell.swift
//  NetflixClone
//
//  Created by Gustavo Colaço on 06/05/22.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionViewTableViewCell"
    
    private var titles: [Title] = []
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 144, height: 200) //change this later
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    private func configureCollectionView() {
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func settingData(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
        }
    }
    
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell()}
        guard let modelPosterPath = titles[indexPath.row].posterPath else { return UICollectionViewCell() }
        cell.setData(with: modelPosterPath)
        return cell
    }
    
}


