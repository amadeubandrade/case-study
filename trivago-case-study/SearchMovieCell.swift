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
    var delegate:MyCustomCellDelegator!
    var imdbUrl: String?
    var youtubeUrl: String?
    var homepageUrl: String?

    
    //MARK: - IBOutlets
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitleAndYear: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var homepageBtn: UIButton!
    @IBOutlet weak var youtubeBtn: UIButton!
    @IBOutlet weak var imdbBtn: UIButton!
    @IBOutlet weak var spinLoadingImage: UIActivityIndicatorView!

    
    //MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        spinLoadingImage.hidesWhenStopped = true
    }
    
    override func drawRect(rect: CGRect) {
        movieOverview.scrollRangeToVisible(NSMakeRange(0, 0))
    }
    
    
    //MARK: - IBActions
    
    @IBAction func onLinkBtnPressed(sender: UIButton) {
        if self.delegate != nil {
            if sender.tag == 0, let url = homepageUrl {
                self.delegate.callSegueFromButtonCell(url: url)
            } else if sender.tag == 1 , let url = youtubeUrl {
                self.delegate.callSegueFromButtonCell(url: url)
            } else if sender.tag == 2, let url = imdbUrl {
                self.delegate.callSegueFromButtonCell(url: url)
            }
        }
    }
    
    
    //MARK: - Cell Configuration
    
    func configureCell(movie: Movie) {
        
        movieImage.image = nil
        spinLoadingImage.startAnimating()
        if let posterUrl = movie.posterUrl {
            if let cachedImage = CacheService.cache.retrieveFromCache(posterUrl) {
                movieImage.image = cachedImage
                spinLoadingImage.stopAnimating()
            } else {
                posterRequest = Alamofire.request(.GET, posterUrl).validate(contentType: REQUEST_CONTENT_TYPE).response(completionHandler: { (_: NSURLRequest?, _: NSHTTPURLResponse?, data: NSData?, error: NSError?) in
                    if error != nil {
                        self.movieImage.image = UIImage(named: "noMovie")
                        self.spinLoadingImage.stopAnimating()
                    } else if let imgData = data {
                        let img = UIImage(data: imgData)!
                        self.movieImage.image = img
                        self.spinLoadingImage.stopAnimating()
                        CacheService.cache.addToCache(img, key: posterUrl)
                    }
                })
            }
        } else {
            movieImage.image = UIImage(named: "noMovie")
            spinLoadingImage.stopAnimating()
        }
        
        movieTitleAndYear.text = "\(movie.name) (\(movie.year))"
        movieOverview.text = movie.overview
        configureLinkBtns(movie.homepageUrl, youtube: movie.youtubeUrl, imdb: movie.imdbUrl)
    }

    
    //MARK: Configure Link Buttons
    
    func configureLinkBtns(homepage: String? = nil, youtube: String? = nil, imdb: String? = nil) {
        if homepage != nil {
            homepageBtn.alpha = 1.0
            homepageBtn.enabled = true
            homepageUrl = homepage
        } else {
            homepageBtn.alpha = 0.4
            homepageBtn.enabled = false
        }
        
        if youtube != nil {
            youtubeBtn.alpha = 1.0
            youtubeBtn.enabled = true
            youtubeUrl = youtube
        } else {
            youtubeBtn.alpha = 0.4
            youtubeBtn.enabled = false
        }
        
        if imdb != nil {
            imdbBtn.alpha = 1.0
            imdbBtn.enabled = true
            imdbUrl = imdb
        } else {
            imdbBtn.alpha = 0.4
            imdbBtn.enabled = false
        }
    }

}
