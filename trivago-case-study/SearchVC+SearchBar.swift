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
            resetRequests()
            tableView.reloadData()
        } else {
            resetRequests()
            spinLoadingMovies.startAnimating()
            let text = searchText.lowercaseString.stringByFoldingWithOptions(.DiacriticInsensitiveSearch, locale: NSLocale.currentLocale())
            textToSearch = text.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
            downloadSearchedMovies(textToSearch!, pageNumber: actualPageNumber, completed: { (success) in
                self.spinLoadingMovies.stopAnimating()
                self.tableView.reloadData()
            })
        }
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(false)
    }
    
    
    //MARK: - Download 
    
    func downloadSearchedMovies(text: String, pageNumber: Int, completed: downloadCompleted) {

        let urlStr = URL_BASE + "/search/movie?query=" + text
        
        let parameters : [String: AnyObject] = [
            "extended": "full,images",
            "limit": REQUEST_PAGE_LIMIT,
            "page": pageNumber
        ]
        
        if let url = NSURL(string: urlStr) {
            movieRequest = Alamofire.request(.GET, url, parameters: parameters, encoding: .URL, headers: REQUEST_HEADER).responseJSON(completionHandler: { (response: Response<AnyObject, NSError>) in

                if let result = response.result.value as? [[String: AnyObject]] {

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
                                        }
                                    }
                                }
                                let movieResult = Movie(name: movieTitle, year: movieYear, overview: overview, posterUrl: posterURL, imdbUrl: imdbURL, youtubeUrl: youtubeURL, homepageUrl: homepageURL)
                                self.filteredMovies.append(movieResult)
                            }
                        } else {
                            completed(success: false)
                        }
                    }
                    completed(success: true)
                
                } else {
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