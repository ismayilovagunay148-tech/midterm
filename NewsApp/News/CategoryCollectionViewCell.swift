//
//  HomeControllerCollectionViewCell.swift
//  NewsApp
//
//  Created by Gunay Ismayilova on 13.09.25.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var categoryView: UIView!
    
    @IBOutlet private weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryView.layer.cornerRadius = categoryView.frame.height / 2
       
    }
    
    func configure(category: Category) {
        categoryLabel.text = category.type.rawValue.capitalized
        categoryView.backgroundColor = category.isSelected ? .init(white: 0.92, alpha: 1.0) : .clear
    }

}
