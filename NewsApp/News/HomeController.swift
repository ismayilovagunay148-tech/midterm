//
//  HomeController.swift
//  NewsApp
//
//  Created by Gunay Ismayilova on 13.09.25.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    @IBOutlet private weak var tableView: UITableView!
    
    var categories: [Category] = []
    
    var allNews: [CategoryType: [NewsDetail]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataFromJSON()

        collectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    func loadDataFromJSON() {
        categories = JSONManager.shared.getCategoriesFromJSON()
        allNews = JSONManager.shared.getAllNewsFromJSON()
        
        if !categories.isEmpty && !categories.contains(where: { $0.isSelected }) {
            categories[0].isSelected = true
        }
    }
    func selectCategory(_ categoryType: CategoryType) {
        // Deselect all categories
        for index in categories.indices {
            categories[index].isSelected = false
        }
        
        // Find and select the target category
        if let index = categories.firstIndex(where: { $0.type == categoryType }) {
            categories[index].isSelected = true
            
            // Reload both collection and table views
            collectionView.reloadData()
            tableView.reloadData()
            
            // Scroll to the selected category in collection view
            let indexPath = IndexPath(item: index, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            // Scroll table view to top
            if let newsCount = allNews[categoryType]?.count, newsCount > 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }


    @IBAction func homeLoginButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "LoginController") as! LoginController
        navigationController?.show(controller, sender: nil)
    }
    
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CategoryCollectionViewCell.self), for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(category: categories[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categories.enumerated().forEach { (index, category) in
            categories[index].isSelected = false
        }
        categories[indexPath.item].isSelected = true
        collectionView.reloadData()
        
        tableView.reloadData()

    }
    
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let selectedCategory = categories.first(where: { $0.isSelected }) else { return 0 }
        
        return allNews[selectedCategory.type]?.count ?? 0
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        
        guard let selectedCategory = categories.first(where: { $0.isSelected }),
              let newsArray = allNews[selectedCategory.type],
              indexPath.row < newsArray.count else { return cell }
         
        let newsItem = newsArray[indexPath.row]
                    
        cell.configure(image: newsItem.image, title: newsItem.title, resource: newsItem.resource, date: newsItem.date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "DetailController") as? DetailController else { return }
        
        guard let selectedCategory = categories.first(where: { $0.isSelected }),
              let news = allNews[selectedCategory.type]?[indexPath.row] else { return }
        
        controller.detail = news
        navigationController?.show(controller, sender: nil)
    }
}

