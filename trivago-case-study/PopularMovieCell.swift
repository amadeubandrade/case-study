//
//  MovieCell.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 28/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class PopularMovieCell: UITableViewCell {

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(name: String, year: String) {
        movieName.text = name
        movieYear.text = year
    }
    

}