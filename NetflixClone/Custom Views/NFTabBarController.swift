//
//  NFTabBarController.swift
//  NetflixClone
//
//  Created by Gustavo Colaço on 05/05/22.
//

import UIKit

class NFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [createMainNC(), createUpcomingNC(), createSearchNC(), createDownloadsNC()]

    }
    
    private func createMainNC() -> UINavigationController {
        let homeVC = HomeViewController()
        homeVC.tabBarItem.title = "Home"
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    private func createUpcomingNC() -> UINavigationController {
        let upcomingVC = UpcomingViewController()
        upcomingVC.tabBarItem.title = "Coming Soon"
        upcomingVC.tabBarItem.image = UIImage(systemName: "play.circle")
        
        return UINavigationController(rootViewController: upcomingVC)
    }
    
    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchViewController()
        searchVC.tabBarItem.title = "Top Search"
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    private func createDownloadsNC() -> UINavigationController {
        let downloadsVC = DownloadsViewController()
        downloadsVC.tabBarItem.title = "Downloads"
        downloadsVC.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        return UINavigationController(rootViewController: downloadsVC)
    }


}
