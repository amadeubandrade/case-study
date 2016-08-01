//
//  MovieCell.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 28/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import Alamofire

class PopularMovieCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var loadingBannerIndicator: UIActivityIndicatorView!
    
    
    //MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadingBannerIndicator.hidesWhenStopped = true
    }
    
    override func drawRect(rect: CGRect) {
        movieImage.clipsToBounds = true
    }
    
    
    //MARK: - Cell Configuration
    
    func configureCell(movie: Movie) {
        if let banner = movie.bannerUrl {
            loadingBannerIndicator.startAnimating()
            hideOutlets(banner: false, labels: true)
            movieImage.image = nil
            if let cachedImg = CacheService.cache.retrieveFromCache(banner) {
                self.movieImage.image = cachedImg
                loadingBannerIndicator.stopAnimating()
            } else {
                Alamofire.request(.GET, banner).validate(contentType: REQUEST_CONTENT_TYPE).response(completionHandler: { (_: NSURLRequest?, _: NSHTTPURLResponse?, data: NSData?, error: NSError?) in
                    if error != nil {
                        self.hideOutlets(banner: true, labels: false)
                        self.loadingBannerIndicator.stopAnimating()
                        self.movieName.text = movie.name
                        self.movieYear.text = "\(movie.year)"
                    } else if let imageData = data {
                        let img = UIImage(data: imageData)!
                        self.movieImage.image = img
                        self.loadingBannerIndicator.stopAnimating()
                        CacheService.cache.addToCache(img, key: banner)
                    }
                })
            }
        } else {
            hideOutlets(banner: true, labels: false)
            loadingBannerIndicator.stopAnimating()
            movieName.text = movie.name
            movieYear.text = "(\(movie.year))"
        }
        
    }
    
    
    //MARK: - Aux
    
    func hideOutlets(banner banner: Bool, labels: Bool) {
        movieImage.hidden = banner
        movieName.hidden = labels
        movieYear.hidden = labels
    }
    

}