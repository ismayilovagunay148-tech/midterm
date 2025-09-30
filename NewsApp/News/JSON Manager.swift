//
//  JSON Manager.swift
//  NewsApp
//
//  Created by Gunay Ismayilova on 24.09.25.
//

import Foundation

class JSONManager {
    static let shared = JSONManager()
    
    private init() {}
    
    func loadNewsData() -> NewsData? {
        guard let url = Bundle.main.url(forResource: "News", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return nil }
        
        do {
            let decoder = JSONDecoder()
            let newsData = try decoder.decode(NewsData.self, from: data)
            return newsData
        } catch {
            return nil
        }
    }
    
    func getCategoriesFromJSON() -> [Category] {
        return loadNewsData()?.categories ?? []
    }
    
    func getAllNewsFromJSON() -> [CategoryType: [NewsDetail]] {
        guard let newsData = loadNewsData() else { return [:] }
        
        var convertedNews: [CategoryType: [NewsDetail]] = [:]
        
        for (key, value) in newsData.allNews {
            if let categoryType = CategoryType(rawValue: key) {
                convertedNews[categoryType] = value
            }
        }
        return convertedNews
    }
}
