//
//  TitlePreviewViewController.swift
//  NetflixClone
//
//  Created by Gustavo Colaço on 10/05/22.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let webview: WKWebView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUIElements()

    }
    
    
    private func configureUIElements() {
        view.addSubview(webview)
        view.addSubview(titleLabel)
        view.addSubview(downloadButton)
        view.addSubview(overviewLabel)
        
        webview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            webview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webview.heightAnchor.constraint(equalToConstant: 350),
            
            titleLabel.topAnchor.constraint(equalTo: webview.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            
            downloadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            downloadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            downloadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            downloadButton.heightAnchor.constraint(equalToConstant: 44),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            overviewLabel.bottomAnchor.constraint(equalTo: downloadButton.topAnchor, constant: -20)
    
        ])
        
    }
    
    
    func configure(with model: YoutubeSearchViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverView
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeVideo.id.videoId)") else { return }
        
        webview.load(URLRequest(url: url))
    }


}
