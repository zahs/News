//
//  ViewController.swift
//  News
//
//  Created by Zhanna Sargsyan on 27/06/2019.
//  Copyright © 2019 Zhanna Sargsyan. All rights reserved.
//

import UIKit

let CELL_HEIGHT = 170

class NewsViewController: UIViewController {
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var newsSegmentControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var networkManager: NetworkManager = NetworkManager()
    private var cellsCountPerPage: Int = 0
    private var articles: [NewsData] = []
    private var isLoading: Bool = false
    private var pageNumber: Int = 1
    private var newsTotalCount: Int = 0
   // private var selectedRequestType: NewsApi = .everything(params: [:])

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        let collectionViewSize = self.newsCollectionView.frame.size
        cellsCountPerPage = Int((collectionViewSize.height / CGFloat(CELL_HEIGHT)).rounded())
        self.newsSegmentControl.setTitle("All", forSegmentAt: 0)
        self.newsSegmentControl.setTitle("Top", forSegmentAt: 1)
        newsSegmentIndexChanged(self)
    }

    
    @IBAction func newsSegmentIndexChanged(_ sender: Any) {
        self.articles.removeAll()
        self.newsTotalCount = 0
        pageNumber = 1
        newsCollectionView.reloadData()
        let requestParams = params(page: pageNumber, pageSize: cellsCountPerPage)
        loadData(page: pageNumber, pageSize: cellsCountPerPage, params: requestParams)
    }
    
    func displayResponseData(newsResponse: NewsResponse?, error: String?) {
        onMain {
            self.activityIndicator.stopAnimating()
            guard error == nil else {
                self.showError(description: error)
                return
            }
            guard let response =  newsResponse else {
                return
            }
            self.articles = response.news
            self.newsTotalCount = response.totalCount
            self.newsCollectionView.reloadData()
        }
        
    }
    
    private func showError(description: String?) {
        onMain() {
            self.errorLabel.text = description ?? "There is an issue of loading news"
            self.errorLabel.isHidden = false
        }
    }
    
    private func hideError() {
        onMain() {
            self.errorLabel.isHidden = true
        }
    }
}

extension NewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if articles.count + cellsCountPerPage > newsTotalCount {
            isLoading = false
            return articles.count
        }
        isLoading = true
        return articles.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isLoading == true, indexPath.row == articles.count {
            let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "loaderCell", for: indexPath) as! LoaderCell
            cell.animateLoader(true)
            pageNumber += 1
            let requestParams = params(page: pageNumber, pageSize: cellsCountPerPage)
            loadData(page: pageNumber, pageSize: cellsCountPerPage, params: requestParams)
            return cell
        }
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCell
        cell.updateCell(with: articles[indexPath.row])
        return cell
    }
    
}

extension NewsViewController {
    func loadData(page: Int, pageSize: Int, params: [String: Any]) {
        if page == 1 {
            activityIndicator.startAnimating()
        }
        pageNumber = page
        switch newsSegmentControl.selectedSegmentIndex {
        case 0:
            networkManager.getAllNews(page: page, pageSize: pageSize, params: params) { (news, error) in
                self.displayResponseData(newsResponse: news, error: error)
            }
        case 1:
            networkManager.getTopNews(page: page, pageSize: pageSize, params: params) { (news, error) in
                self.displayResponseData(newsResponse: news, error: error)
            }
        default:
            print("No page is available")
        }
    }
    
    func params(page: Int, pageSize: Int) -> [String: Any] {
        switch newsSegmentControl.selectedSegmentIndex {
        case 0:
            return ["q" : "bitcoin",
                    "pageSize": "\(pageSize)",
                    "page": "\(page)"]
            
        case 1:
            return ["country" : CountryCode.us.rawValue,
                    "pageSize": "\(pageSize)",
                    "page": "\(page)"]
        default:
            print("no page available")
            return [:]
        }
    }
}
