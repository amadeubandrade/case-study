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
            movieImage.hidden = false
            movieName.hidden = true
            movieYear.hidden = true
            movieImage.image = nil
            bannerRequest = Alamofire.request(.GET, banner).response(completionHandler: { (_: NSURLRequest?, _: NSHTTPURLResponse?, data: NSData?, error: NSError?) in
                if error != nil {
                    print(error)
                } else if let imageData = data {
                    let img = UIImage(data: imageData)
                    self.movieImage.image = img
                } else {
                    print("Unknown error")
                }
            })
            
        } else {
            movieImage.hidden = true
            movieName.hidden = false
            movieYear.hidden = false
            movieName.text = movie.name
            movieYear.text = "\(movie.year)"
        }
        
    }
    

}