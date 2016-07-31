//
//  SearchVC+SearchBar.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 31/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import Alamofire

extension SearchVC {
    
    //MARK: - Search Bar Methods
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            view.endEditing(true)
        } else {
            print(searchText)
            movieRequest?.cancel()
            imageRequest?.cancel()
            filteredMovies = []

            let text = searchText.lowercaseString
            
            downloadSearchedMovies(text, completed: { (success) in
                if success {
                    self.tableView.reloadData()
                } else {
                    let alert = UIAlertController(title: "Problem found", message: "There was a problem with your request. Please try again later.", preferredStyle: .Alert)
                    let action = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(false)
    }
    
    //MARK: - Download 
    
    func downloadSearchedMovies(text: String, completed: downloadCompleted) {

        let urlStr = URL_BASE + "/search/movie?query=" + text
        
        let parameters : [String: AnyObject] = [
            "extended": "full,images",
            "limit": REQUEST_PAGE_LIMIT,
            "page": actualPageNumber
        ]
        
        if let url = NSURL(string: urlStr) {
            movieRequest = Alamofire.request(.GET, url, parameters: parameters, encoding: .URL, headers: REQUEST_HEADER).responseJSON(completionHandler: { (response: Response<AnyObject, NSError>) in

                if let result = response.result.value as? [[String: AnyObject]] where !result.isEmpty {

                    for movieEntry in result {

                        if let movie = movieEntry["movie"] as? [String: AnyObject] {

                            var movieTitle: String!
                            var movieYear: String!
                            var imdbURL: String?
                            var youtubeURL: String?
                            var homepageURL: String?
                            var overview: String?
                            var posterURL: String?
                            
                            if let title = movie["title"] as? String, let year = movie["year"] as? Int {
                                movieTitle = title
                                movieYear = "\(year)"
                                if let ids = movie["ids"] as? [String: AnyObject] {
                                    if let imdb = ids["imdb"] as? String {
                                        imdbURL = "http://www.imdb.com/title/\(imdb)/"
                                    }
                                }
                                if let youtube = movie["trailer"] as? String {
                                    youtubeURL = youtube
                                }
                                
                                if let homepage = movie["homepage"] as? String {
                                    homepageURL = homepage
                                }
                                if let overviewTxt = movie["overview"] as? String {
                                    overview = overviewTxt
                                } else {
                                    overview = "No information available."
                                }
                                if let images = movie["images"] as? [String: AnyObject] {
                                    if let poster = images["poster"] as? [String: AnyObject] {
                                        if let posterStr = poster["thumb"] as? String {
                                            posterURL = posterStr
                                            //TODO: - Download image
                                        }
                                    }
                                }
                                let movieResult = Movie(name: movieTitle, year: movieYear, overview: overview, posterUrl: posterURL, imdbUrl: imdbURL, youtubeUrl: youtubeURL, homepageUrl: homepageURL)
                                self.filteredMovies.append(movieResult)
                            }
                        } else {
                            //TODO: - NO MOVIES TO SHOW
                            completed(success: false)
                        }
                    }
                    completed(success: true)
                
                } else {
                    //no results to show -> ALERT IN THIS MOMENT.. change it
                    completed(success: false)
                }
            })
        } else {
            let alert = UIAlertController(title: "Problem found", message: "There was a problem with the Url. Please try again later.", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }

}