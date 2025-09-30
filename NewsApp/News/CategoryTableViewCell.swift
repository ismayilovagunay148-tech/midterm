//
//  HomeControllerTableViewCell.swift
//  NewsApp
//
//  Created by Gunay Ismayilova on 14.09.25.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var detailView: UIView!
    
    @IBOutlet private weak var detailImage: UIImageView!
    
    @IBOutlet private weak var detailTitleLabel: UILabel!
    
    @IBOutlet private weak var detailResourceLabel: UILabel!
    
    @IBOutlet private weak var detailDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailView.layer.cornerRadius = 20
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(image: String, title: String, resource: String, date: String) {
        detailImage.image = UIImage(named: image)
        detailTitleLabel.text = title
        detailResourceLabel.text = resource
        detailDateLabel.text = date
        
    }
}

