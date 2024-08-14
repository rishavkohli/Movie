//
//  ViewController.swift
//  Movie
//
//  Created by Rishav Kohli on 13/08/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            let vc = MovieSearchHomeScreenBuilder.buildMovieSearchHomeScreenModule()
            vc.modalPresentationStyle = .overFullScreen
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self?.present(navController, animated: false)        }
    }


}

