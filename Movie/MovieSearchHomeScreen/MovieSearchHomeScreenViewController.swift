//
//  MovieSearchHomeScreenViewController.swift
//  Movie
//
//  Created by Rishav Kohli on 13/08/24.

import Foundation
import UIKit

final class MovieSearchHomeScreenViewController: UIViewController, MovieSearchHomeScreenViewProtocol {

    private let presenter: MovieSearchHomeScreenPresenterProtocol

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Movies"
        label.font = .systemFont(ofSize: 28)
        return label
    }()

    private let searchContainer: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()

    private let searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search")
        return imageView
    }()

    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search Any Movie"
        textField.font = .systemFont(ofSize: 15)
        return textField
    }()

    private let submitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("Find", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()

    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10

        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.clipsToBounds = true
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.alwaysBounceVertical = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    private let errorLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        return label
    }()


    init(presenter: MovieSearchHomeScreenPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerCells()
    }

    private func setupView(){
        self.view.backgroundColor = .white
        self.view.addSubviews(titleLabel,searchContainer,collectionView, errorLabel)

       // title constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

        // searchContainer constraints
         searchContainer.translatesAutoresizingMaskIntoConstraints = false
        searchContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        searchContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        searchContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        searchContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true

        // searchContainer constraints
         collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: 10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true

        // errorLabel constraints

        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.topAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: 10).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true



        searchContainer.addSubviews(searchIcon,textField,submitButton)

        // searchIcon constraints
        searchIcon.translatesAutoresizingMaskIntoConstraints = false
        searchIcon.topAnchor.constraint(equalTo: searchContainer.topAnchor, constant: 10).isActive = true
        searchIcon.leadingAnchor.constraint(equalTo: searchContainer.leadingAnchor, constant: 2).isActive = true
        searchIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        searchIcon.bottomAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: -10).isActive = true

        // submitButton constraints
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.topAnchor.constraint(equalTo: searchContainer.topAnchor, constant: 0).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: searchContainer.trailingAnchor, constant: 0).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: 0).isActive = true

        // textField constraints
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: searchContainer.topAnchor, constant: 2).isActive = true
        textField.trailingAnchor.constraint(equalTo: submitButton.leadingAnchor, constant: -10).isActive = true
        textField.leadingAnchor.constraint(equalTo: searchIcon.trailingAnchor, constant: 10).isActive = true
        textField.bottomAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: -2).isActive = true



        collectionView.delegate = self
        collectionView.dataSource = self
        textField.becomeFirstResponder()
        textField.delegate = self
        submitButton.addTarget(self, action: #selector(startSearch), for: .touchUpInside)
    }



    @objc private func startSearch() {
        guard let title = textField.text else {
            return
        }
        self.textField.resignFirstResponder()
        self.presenter.getListOfMovies(searchText: title) { [weak self] success in
            if let success, success == true {
                DispatchQueue.main.async {
                    self?.errorLabel.isHidden = true
                    self?.collectionView.isHidden = false
                    self?.collectionView.reloadData()
                    self?.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    self?.collectionView.scrollsToTop = true
                }

            } else {
                DispatchQueue.main.async {
                    self?.errorLabel.isHidden = false
                    self?.collectionView.isHidden = true
                    self?.errorLabel.text = "No Movies Found!"
                }

            }
        }
    }



    private func registerCells() {
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: MovieCollectionViewCell.self))
    }
}


// MARK: - Collection View Delegate

extension MovieSearchHomeScreenViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = self.presenter.getDataForIndex(index: indexPath.row), movie.imdbId != nil {
            self.presenter.movieTapped(movie: movie)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.presenter.getNextPageData(index: indexPath.row) { [weak self] indexPaths in
            DispatchQueue.main.async {
                self?.collectionView.performBatchUpdates({
                    self?.collectionView.insertItems(at: indexPaths)
                    }, completion: nil)
            }
        }
    }

}

// MARK: - Collection View Data Source

extension MovieSearchHomeScreenViewController: UICollectionViewDataSource {

    private static let movieCellIdentifier = "MovieCollectionViewCell"

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return self.presenter.getNumberOfItems()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        if let movie = self.presenter.getDataForIndex(index: indexPath.row), let movieCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: MovieCollectionViewCell.self),
            for: indexPath
        ) as? MovieCollectionViewCell {
            movieCell.configure(movie: movie)
            return movieCell
        }

        return UICollectionViewCell()
    }

}

// MARK: - Flow Layout Delegate

extension MovieSearchHomeScreenViewController: UICollectionViewDelegateFlowLayout {

    private static let portraitWidth: CGFloat = {
        min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
    }()

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 150, height: 250)
    }

}

// MARK: - Text Field Delegate

extension MovieSearchHomeScreenViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }

}


