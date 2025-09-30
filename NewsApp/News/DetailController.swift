//
//  DetailController.swift
//  NewsApp
//
//  Created by Gunay Ismayilova on 21.09.25.
//

import UIKit

class DetailController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var viewController: UIView!
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var infoLabel: UILabel!
    
    @IBOutlet private weak var resourceLabel: UILabel!
    
    @IBOutlet private weak var dateLabel: UILabel!
    
    var detail: NewsDetail? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayNewsInformation()
        setupUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateScrollViewContentSize()
    }
    
    func setupUI() {
        scrollView.isScrollEnabled = true
        scrollView.bounces = true
        scrollView.alwaysBounceVertical = true
        titleLabel.lineBreakMode = .byWordWrapping
        infoLabel.lineBreakMode = .byWordWrapping
    }
    
    func displayNewsInformation() {
        guard let news = detail else { return }
        imageView.image = UIImage(named: news.image)
        titleLabel.text = news.title
        resourceLabel.text = news.resource
        dateLabel.text = news.date
        infoLabel.text = news.details
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    func updateScrollViewContentSize() {
        let spacing: CGFloat = 16
        var totalHeight: CGFloat = spacing
        
        totalHeight += imageView.frame.height + spacing
        
        let titleSize = titleLabel.sizeThatFits(CGSize(width: titleLabel.frame.width, height: .greatestFiniteMagnitude))
        totalHeight += titleSize.height + spacing
        
        let infoSize = infoLabel.sizeThatFits(CGSize(width: infoLabel.frame.width, height: .greatestFiniteMagnitude))
        totalHeight += infoSize.height + spacing
        
        totalHeight += resourceLabel.frame.height + spacing
        totalHeight += dateLabel.frame.height + spacing * 2
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: max(totalHeight, scrollView.frame.height + 1))
    }
}
