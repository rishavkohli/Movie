//
//  DetailViewController.swift
//  Movie
//
//  Created by Rishav Kohli on 14/08/24.
//

import UIKit

// MARK: - Detail View Controller

class DetailViewController: UIViewController, DetailsScreenViewProtocol {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    

    private var movie: Movie?
    private var movieDetail: MovieDetail?
    private var posterImage: URL?
    var presenter : DetailsScreenPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        self.view.backgroundColor = .white

        titleLabel.text = movie?.title

        if let year = movie?.year {
            yearLabel.text = "(\(year))"
        } else {
            yearLabel.text = nil
        }

        if let url = posterImage {
            posterImageView.load(url: url)
        }

        detailTableView.backgroundColor = .white

        loadingView.startAnimating()
        errorLabel.isHidden = true

        self.presenter?.getDetails(completion: { [weak self] success in
            DispatchQueue.main.async {
                if let success, success == true {
                    // success case
                    self?.loadingView.stopAnimating()
                    self?.loadingView.isHidden = true
                    self?.detailTableView.reloadData()
                }
                else {
                    // error case
                    self?.loadingView.isHidden = true
                    self?.loadingView.stopAnimating()
                    self?.errorLabel.isHidden = false
                    self?.detailTableView.isHidden = true
                }
            }
        })
    }

}

// MARK: - Configuration

extension DetailViewController {

    func configure(movie: Movie) {
        self.movie = movie
        if let movieImage = movie.poster, let url = URL(string: movieImage) {
            self.posterImage = url
        }
    }

}


// MARK: - Table View Data Source

extension DetailViewController: UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        self.presenter?.getNumberOfRows() ?? 0
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "DetailTableViewCell"
            ) as? DetailTableViewCell, let detail = self.presenter?.getDataForIndex(index: indexPath.row)
        else {
            return UITableViewCell()
        }
        cell.configureCell(heading: detail.heading, details: detail.text)

        return cell
    }

}

// MARK: - Table View Delegate

extension DetailViewController: UITableViewDelegate {}
