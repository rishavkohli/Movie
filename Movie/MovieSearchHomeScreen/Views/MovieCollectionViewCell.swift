//
//  MovieCollectionViewCell.swift
//  Movie
//
//  Created by Rishav Kohli on 13/08/24.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Movies"
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    var movie: Movie?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }

    override func prepareForReuse() {
        self.titleLabel.text = nil
        self.posterImageView.image = nil
    }

    private func setupCell() {
        self.addSubviews(titleLabel,posterImageView)

        // posterImageView constraints
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true

       // title constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }

}

// MARK: - Cell Configuration

extension MovieCollectionViewCell {

    func configure(movie: Movie) {
        self.movie = movie

        titleLabel.text = movie.title

        if let image = movie.poster, let posterImageUrl = URL(string: image) {
            posterImageView.load(url: posterImageUrl)
        }

        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
