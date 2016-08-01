//
//  DetailsVC.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 01/08/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import Alamofire

class DetailsVC: UIViewController {
    
    //MARK: - Properties
    
    var movie: Movie!
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var movieTitleAndYear: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var homepageBtn: UIButton!
    @IBOutlet weak var youtubeBtn: UIButton!
    @IBOutlet weak var imdbBtn: UIButton!
    @IBOutlet weak var movieOverview: UILabel!

    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    //MARK: IBActions
    
    @IBAction func onLinkBtnPressed(sender: UIButton) {
        if sender.tag == 0 {
            performSegueWithIdentifier(SEGUE_WEB_VC, sender: movie.homepageUrl)
        } else if sender.tag == 1 {
            performSegueWithIdentifier(SEGUE_WEB_VC, sender: movie.youtubeUrl)
        } else if sender.tag == 2 {
            performSegueWithIdentifier(SEGUE_WEB_VC, sender: movie.imdbUrl)
        }
    }
    
    
    //MARK: - Update UI
    
    func updateUI(){
        movieTitleAndYear.text = "\(movie.name) (\(movie.year))"
        
        if let imageUrl = movie.posterUrl {
            if let img = CacheService.cache.retrieveFromCache(imageUrl) {
                movieImage.image = img
            } else {
                Alamofire.request(.GET, imageUrl).validate(contentType: REQUEST_CONTENT_TYPE).response(completionHandler: { (_: NSURLRequest?, _: NSHTTPURLResponse?, data: NSData?, error: NSError?) in
                    if error != nil {
                        let img = UIImage(named: "noMovie")
                        self.movieImage.image = img
                    } else if let imgData = data {
                        let img = UIImage(data: imgData)!
                        self.movieImage.image = img
                        CacheService.cache.addToCache(img, key: imageUrl)
                    }
                })
            }
        } else {
            let img = UIImage(named: "noMovie")
            movieImage.image = img
        }
        
        configureLinkBtns(movie.homepageUrl, youtube: movie.youtubeUrl, imdb: movie.imdbUrl)
        
        if let overview = movie.overview {
            movieOverview.text = overview
        } else {
            movieOverview.text = "No information available."
        }
    }
    
    
    //MARK: Configure Link Buttons
    
    func configureLinkBtns(homepage: String? = nil, youtube: String? = nil, imdb: String? = nil) {
        if homepage != nil {
            homepageBtn.alpha = 1.0
            homepageBtn.enabled = true
        } else {
            homepageBtn.alpha = 0.4
            homepageBtn.enabled = false
        }
        
        if youtube != nil {
            youtubeBtn.alpha = 1.0
            youtubeBtn.enabled = true
        } else {
            youtubeBtn.alpha = 0.4
            youtubeBtn.enabled = false
        }
        
        if imdb != nil {
            imdbBtn.alpha = 1.0
            imdbBtn.enabled = true
        } else {
            imdbBtn.alpha = 0.4
            imdbBtn.enabled = false
        }
    }

    
    //MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SEGUE_WEB_VC {
            if let webVC = segue.destinationViewController as? WebVC {
                if let url = sender as? String {
                    webVC.urlStr = url
                }
            }
        }
    }

}
