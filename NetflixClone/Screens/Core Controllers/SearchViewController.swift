//
//  SearchViewController.swift
//  NetflixClone
//
//  Created by Gustavo Colaço on 05/05/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var titles: [Title] = []
    
    private let discoverTableView: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movie or a TV Show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(discoverTableView)
        discoverTableView.delegate = self
        discoverTableView.dataSource = self
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .white
        
        fetchDiscoverMovies()
        
        searchController.searchResultsUpdater = self
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTableView.frame = view.bounds
    }
    
    private func fetchDiscoverMovies() {
        NetworkManager.shared.getDiscoverMovies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let titles):
                self.titles = titles
                DispatchQueue.main.async {
                    self.discoverTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        
        let title = titles[indexPath.row]
        cell.setData(with: TitleViewModel(titleName: title.title ?? title.originalTitle ?? "Unable to fetch title", posterURL: title.posterPath ?? ""))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty, query.trimmingCharacters(in: .whitespaces).count >= 3, let resultsController = searchController.searchResultsController as? SearchResultsViewController else  { return }
        
        NetworkManager.shared.search(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultsController.titles = titles
                    resultsController.searchResultsCollectionView.reloadData()
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
}
