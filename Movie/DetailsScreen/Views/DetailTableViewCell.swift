//
//  DetailTableViewCell.swift
//  Movie
//
//  Created by Rishav Kohli on 14/08/24.
//

import UIKit

// MARK: - Detail Table View Cell

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var headingLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!

    func configureCell(heading: String?, details: String?) {
        self.headingLabel.text = heading
        self.detailLabel.text = details
    }

}
