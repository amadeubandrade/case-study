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
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!

    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        downloadPopularMovies(pageNumber) { (success) in
            if success {
                print("ok")
            } else {
                print("error")
            }
        }
    }
    
    func downloadPopularMovies(pageNr: Int, completed: downloadCompleted) {
        
        let headers = [
            "Content-Type": "application/json",
            "trakt-api-version": "2",
            "trakt-api-key": KEY_TRAKT
        ]
        
        let parameters = [
            "extended": "full,images",
            "limit": "\(pageLimit)",
            "page": "{\(pageNr)}"
        ]
        
        let urlStr = "https://api.trakt.tv/movies/popular"
        
        if let url = NSURL(string: urlStr) {
            Alamofire.request(.GET, url, parameters: parameters, encoding: .URL, headers: headers).responseJSON { (response: Response<AnyObject, NSError>) in
                
                if let result = response.result.value as? [[String: AnyObject]] {

                    for movie in result {
                        //title
                        //year
                        //imdb
                        //youtube
                        //homepage
                        //overview
                        //banner
                        //poster
                    }

                    completed(success: true)

                } else {
                    print("no json")
                }
            }
        
        }
    }
    



}

