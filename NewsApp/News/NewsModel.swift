//
//  News.swift
//  NewsApp
//
//  Created by Gunay Ismayilova on 13.09.25.
//

import Foundation

enum CategoryType: String, CaseIterable, Codable {
    case business
    case health
    case science
    case sports
}

struct Category: Codable {
    let type: CategoryType
    var isSelected: Bool = false
}

struct NewsDetail: Codable {
    var image: String
    var title: String
    var resource: String
    var date: String
    var details: String
}
struct NewsData: Codable {
    let categories: [Category]
    let allNews: [String: [NewsDetail]]
}
