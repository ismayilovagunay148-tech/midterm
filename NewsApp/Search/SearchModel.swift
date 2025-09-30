//
//  SearchModel.swift
//  NewsApp
//
//  Created by Gunay Ismayilova on 29.09.25.
//

import Foundation
enum SearchResult {
    case category(CategoryType)
    case news(NewsDetail, category: CategoryType)
}
