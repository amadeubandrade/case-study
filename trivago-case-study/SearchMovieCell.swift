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
    var delegate:MyCustomCellDelegator!
    var url: String?

    
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
    
    
    //MARK: - IBActions
    
    @IBAction func onLinkBtnPressed(sender: UIButton) {
        if self.delegate != nil {
            if let urlStr = url {
                self.delegate.callSegueFromButtonCell(url: urlStr)
            }
        }
    }
    
    
    //MARK: - Cell Configuration
    
    func configureCell(movie: Movie) {
        // movieImage.image =
        movieTitleAndYear.text = "\(movie.name) (\(movie.year))"
        movieOverview.text = movie.overview
        configureLinkBtns(movie.homepageUrl, youtube: movie.youtubeUrl, imdb: movie.imdbUrl)
    }

    
    //MARK: Configure Link Buttons
    
    func configureLinkBtns(homepage: String? = nil, youtube: String? = nil, imdb: String? = nil) {
        if homepage != nil {
            homepageBtn.alpha = 1.0
            homepageBtn.enabled = true
            url = homepage
        } else {
            homepageBtn.alpha = 0.4
            homepageBtn.enabled = false
        }
        
        if youtube != nil {
            youtubeBtn.alpha = 1.0
            youtubeBtn.enabled = true
            url = youtube
        } else {
            youtubeBtn.alpha = 0.4
            youtubeBtn.enabled = false
        }
        
        if imdb != nil {
            imdbBtn.alpha = 1.0
            imdbBtn.enabled = true
            url = imdb
        } else {
            imdbBtn.alpha = 0.4
            imdbBtn.enabled = false
        }
    }

}
