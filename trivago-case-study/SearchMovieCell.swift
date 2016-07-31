//
//  SearchMovieCell.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 31/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import Alamofire

class SearchMovieCell: UITableViewCell {
    
    //MARK: - Properties
    
    var posterRequest: Request?
    let acceptableContentType = ["image/jpeg", "image/gif", "image/png"]


    //MARK: - IBOutlets
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleAndYear: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var homepageBtn: UIButton!
    @IBOutlet weak var youtubeBtn: UIButton!
    @IBOutlet weak var imdbBtn: UIButton!

    
    //MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //IBActions
    @IBAction func onLinkBtnPressed(sender: UIButton) {
        //0 - homepage
        //1 - youtube
        //2 - imdb
    }
    
    
    //MARK: - Cell Configuration
    
    func configureCell(movie: Movie) {
        //
       // movieImage.image =
        movieTitleAndYear.text = "\(movie.name) (\(movie.year))"
        movieOverview.text = movie.overview
        
    }

    
    //MARK: - Auxiliary Functions
    func configureLinks(homepage: String, youtube: String, imdb: String) {
        //
    }

}
