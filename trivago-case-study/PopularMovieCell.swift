//
//  MovieCell.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 28/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class PopularMovieCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    
    //MARK: - Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    //MARK: - Cell Configuration
    
    func configureCell(name: String, year: String) {
        //TODO: - Need to change this when creating movie's class
        movieName.text = name
        movieYear.text = year
    }
    

}