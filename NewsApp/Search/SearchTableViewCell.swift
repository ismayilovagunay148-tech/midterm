//
//  SearchTableViewCell.swift
//  NewsApp
//
//  Created by Gunay Ismayilova on 29.09.25.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var resultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configureCell(title: String) {
        resultLabel.text = title
    }
    
}
