//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Gustavo Colaço on 05/05/22.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTV = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    private let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Popular", "Upcoming movies", "Top rated"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureHomeFeedTable()
        configureNavBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    

    
    private func configureNavBar() {
        var image = UIImage(named: "netflix")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
                                              UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)]
        navigationController?.navigationBar.tintColor = .white
    }
    
    
    private func configureHomeFeedTable() {
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        let headerView = HomeFeaturedHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
        homeFeedTable.tableHeaderView = headerView
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            NetworkManager.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    cell.settingData(with: titles)
                case .failure:
                    print("error getting trending movies")
                }
            }
        case Sections.TrendingTV.rawValue:
            NetworkManager.shared.getTrendingTVShow { result in
                switch result {
                case .success(let titles):
                    cell.settingData(with: titles)
                case .failure:
                    print("error getting trending Tvs")
                }
            }
        case Sections.Popular.rawValue:
            NetworkManager.shared.getPopularMovies { result in
                switch result {
                case .success(let titles):
                    cell.settingData(with: titles)
                case .failure:
                    print("error getting popular movies")
                }
            }
        case Sections.Upcoming.rawValue:
            NetworkManager.shared.getUpcomingMovies { result in
                switch result {
                case .success(let titles):
                    cell.settingData(with: titles)
                case .failure:
                    print("error getting upcoming movies")
                }
            }
        case Sections.TopRated.rawValue:
            NetworkManager.shared.getTopRatedMovies { result in
                switch result {
                case .success(let titles):
                    cell.settingData(with: titles)
                case .failure:
                    print("error getting top rated movies")
                }
            }
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header  = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .label
        header.textLabel?.text = header.textLabel?.text?.capitalizedFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    
}
