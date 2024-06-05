//
//  NewsTableViewCell.swift
//  NewsWave
//
//  Created by Eduardo on 16/05/24.
//
import Foundation
import UIKit

class NewsTableViewCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let sourceLabel = UILabel()
    private let publishedAtLabel = UILabel()
    private let articleImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        publishedAtLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(articleImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(publishedAtLabel)
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            articleImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            sourceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            sourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            publishedAtLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 4),
            publishedAtLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            publishedAtLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            publishedAtLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        sourceLabel.numberOfLines = 1
        sourceLabel.font = UIFont.italicSystemFont(ofSize: 14)
        sourceLabel.textColor = .gray
        
        publishedAtLabel.numberOfLines = 1
        publishedAtLabel.font = UIFont.systemFont(ofSize: 14)
        publishedAtLabel.textColor = .gray
    }
    
    func configure(with article: Article, image: UIImage?) {
        titleLabel.text = article.title
        sourceLabel.text = article.source.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        publishedAtLabel.text = dateFormatter.string(from: article.publishedAt)
        
        articleImageView.image = image ?? UIImage(systemName: "photo")
    }
}
