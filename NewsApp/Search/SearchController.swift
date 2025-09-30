//
//  SearchController.swift
//  NewsApp
//
//  Created by Gunay Ismayilova on 24.09.25.
//

import UIKit

class SearchController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var categories: [CategoryType] = []
    private var allNewsItems: [(category: CategoryType, news: NewsDetail)] = []
    private var filteredResults: [SearchResult] = []
    private var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchBar()
        loadNewsData()
        
        tableView.isHidden = true
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil),
                          forCellReuseIdentifier: "SearchTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = true
    }
    
    private func loadNewsData() {
        categories = JSONManager.shared.getCategoriesFromJSON().map { $0.type }
        
        let allNews = JSONManager.shared.getAllNewsFromJSON()
        
        for (categoryType, newsArray) in allNews {
            for newsItem in newsArray {
                allNewsItems.append((category: categoryType, news: newsItem))
            }
        }
        
        tableView.reloadData()
    }
    
    private func filterResults(with searchText: String) {
        guard !searchText.isEmpty else {
            isSearching = false
            filteredResults.removeAll()
            tableView.isHidden = true
            return
        }
        isSearching = true
        filteredResults.removeAll()
        
        tableView.isHidden = false
        
        let lowercasedSearch = searchText.lowercased()
        
        for category in categories {
            if category.rawValue.lowercased().contains(lowercasedSearch) {
                filteredResults.append(.category(category))
            }
        }
        for item in allNewsItems {
            let titleMatch = item.news.title.lowercased().contains(lowercasedSearch)
            
            if titleMatch {
                filteredResults.append(.news(item.news, category: item.category))
            }
        }
        if filteredResults.isEmpty {
            showNoResultsAlert(searchText: searchText)
        }
        
        tableView.reloadData()
   
    }
    
    private func showNoResultsAlert(searchText: String) {
        let alert = UIAlertController(
            title: "No Results Found",
            message: "No results found for \(searchText)",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
 
    }
 }
extension SearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredResults.count
        }
        return categories.count + allNewsItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        if isSearching {
            let result = filteredResults[indexPath.row]
            
            switch result {
            case .category(let categoryType):
                cell.configureCell(title: categoryType.rawValue.capitalized)
            case .news(let newsDetail, _):
                cell.configureCell(title: newsDetail.title)
            }
        } else {
            if indexPath.row < categories.count {
                let category = categories[indexPath.row]
                cell.configureCell(title: category.rawValue.capitalized)
            } else {
                let newsIndex = indexPath.row - categories.count
                let newsItem = allNewsItems[newsIndex]
                cell.configureCell(title: newsItem.news.title)
            }
        }
        return cell
    }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
       if isSearching {
           let result = filteredResults[indexPath.row]
           
           switch result {
           case .category(let categoryType):
               navigateToCategory(categoryType)
           case .news(let newsDetail, _):
               navigateToNewsDetail(newsDetail)
           }
       } else {
           if indexPath.row < categories.count {
               let category = categories[indexPath.row]
               navigateToCategory(category)
           } else {
               let newsIndex = indexPath.row - categories.count
               let newsItem = allNewsItems[newsIndex]
               navigateToNewsDetail(newsItem.news)
           }
       }
   }
    private func navigateToCategory(_ category: CategoryType) {
        if let homeController = navigationController?.viewControllers.first(where: { $0 is HomeController }) as? HomeController {
            homeController.selectCategory(category)
            navigationController?.popToViewController(homeController, animated: true)
        } else {
            guard let homeController = storyboard?.instantiateViewController(withIdentifier: "HomeController") as? HomeController else { return }

            homeController.loadViewIfNeeded()
            homeController.selectCategory(category)
            navigationController?.pushViewController(homeController, animated: true)
        }
    }
    private func navigateToNewsDetail(_ newsDetail: NewsDetail) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "DetailController") as? DetailController else { return }
        controller.detail = newsDetail
        navigationController?.show(controller, sender: nil)
        }
    }
 extension SearchController: UISearchBarDelegate {
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         filterResults(with: searchText)
     }
     
     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         searchBar.resignFirstResponder()
     }
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
         searchBar.text = ""
         searchBar.resignFirstResponder()
         isSearching = false
         filteredResults.removeAll()
         tableView.reloadData()
     }
 }



    
