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
    
    //MARK: - Properties
    
    var bannerRequest: Request?
    let acceptableContentType = ["image/jpeg", "image/gif", "image/png"]
    let cache = NSCache()
    

    //MARK: - Outlets
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    
    //MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func drawRect(rect: CGRect) {
        movieImage.clipsToBounds = true
    }
    
    
    //MARK: - Cell Configuration
    
    func configureCell(movie: Movie) {
        if let banner = movie.bannerUrl {
            hideOutlets(banner: false, labels: true)
            movieImage.image = nil
            
            if let img = cache.objectForKey(banner) as? UIImage {
                //Retrieve image from cache
                self.movieImage.image = img
            } else {
                bannerRequest = Alamofire.request(.GET, banner).validate(contentType: acceptableContentType).response(completionHandler: { (_: NSURLRequest?, _: NSHTTPURLResponse?, data: NSData?, error: NSError?) in
                    if error != nil {
                        self.hideOutlets(banner: true, labels: false)
                        self.movieName.text = movie.name
                        self.movieYear.text = "\(movie.year)"
                    } else if let imageData = data {
                        let img = UIImage(data: imageData)!
                        self.movieImage.image = img
                        //Add image to cache
                        self.cache.setObject(img, forKey: banner)
                    }
                })
            }
        } else {
            hideOutlets(banner: true, labels: false)
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