//
//  ViewController.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 28/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import Alamofire

class InitialVC: UIViewController {
    
    //MARK: - Properties
    
    var pageNumber = 1
    let pageLimit = 10
    var popularMovies = [Movie]()
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!

    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        downloadPopularMovies(pageNumber) { (success) in
            if success {
                self.tableView.reloadData()
            } else {
                let alert = UIAlertController(title: "Problem found!", message: "There was a problem with your request. Please try again later.", preferredStyle: .Alert)
                let action = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                alert.addAction(action)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    //MARK: - IBActions
    
    @IBAction func onSearchBtnPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier(SEGUE_SEARCH_VC, sender: nil)
    }
    
    
    //MARK: - Auxiliary Functions
    
    func downloadPopularMovies(pageNr: Int, completed: downloadCompleted) {
        
        let urlStr = URL_BASE + "movies/popular"

        let headers = [
            "Content-Type": "application/json",
            "trakt-api-version": "2",
            "trakt-api-key": KEY_TRAKT
        ]
        
        let parameters : [String: AnyObject] = [
            "extended": "full,images",
            "limit": pageLimit,
            "page": pageNr
        ]
        
        
        if let url = NSURL(string: urlStr) {
            Alamofire.request(.GET, url, parameters: parameters, encoding: .URL, headers: headers).responseJSON { (response: Response<AnyObject, NSError>) in

                if let result = response.result.value as? [[String: AnyObject]] {

                    for movieEntry in result {
                        
                        var movieTitle: String!
                        var movieYear: String!
                        var imdbURL: String?
                        var youtubeURL: String?
                        var homepageURL: String?
                        var overview: String?
                        var bannerURL: String?
                        var posterURL: String?
                        
                        if let title = movieEntry["title"] as? String, let year = movieEntry["year"] as? Int {
                            movieTitle = title
                            movieYear = "\(year)"
                            if let ids = movieEntry["ids"] as? [String: AnyObject] {
                                if let imdb = ids["imdb"] as? String {
                                    imdbURL = "http://www.imdb.com/title/\(imdb)/"
                                }
                            }
                            if let youtube = movieEntry["trailer"] as? String {
                                youtubeURL = youtube
                            }
                            
                            if let homepage = movieEntry["homepage"] as? String {
                                homepageURL = homepage
                            }
                            if let overviewTxt = movieEntry["overview"] as? String {
                                overview = overviewTxt
                            }
                            if let images = movieEntry["images"] as? [String: AnyObject] {
                                if let poster = images["poster"] as? [String: AnyObject] {
                                    if let posterStr = poster["thumb"] as? String {
                                        posterURL = posterStr
                                    }
                                }
                                if let banner = images["banner"] as? [String: AnyObject] {
                                    if let bannerStr = banner["full"] as? String {
                                        bannerURL = bannerStr
                                    }
                                }
                            }
                            let movie = Movie(name: movieTitle, year: movieYear, overview: overview, posterUrl: posterURL, bannerUrl: bannerURL, imdbUrl: imdbURL, youtubeUrl: youtubeURL, homepageUrl: homepageURL)
                            self.popularMovies.append(movie)
                        }

                    }

                    completed(success: true)

                } else {
                    completed(success: false)
                }
            }
        
        } else {
            let alert = UIAlertController(title: "Problem found!", message: "There was a problem with the Url. Please try again later.", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    

}

