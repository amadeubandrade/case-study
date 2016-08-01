//
//  SearchVC.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 31/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import Alamofire

class SearchVC: UIViewController, UISearchBarDelegate, MyCustomCellDelegator {
    
    //MARK: - Properties
    
    var filteredMovies = [Movie]()
    var movieRequest: Request?
    var imageRequest: Request?
    var actualPageNumber = 1
    var textToSearch: String?
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = .Done
    }
    
    
    //MARK: - Auxiliary Functions
    
    func resetRequests() {
        movieRequest?.cancel()
        imageRequest?.cancel()
        filteredMovies = []
        actualPageNumber = 1
    }
    
    
    //MARK: - MyCustomCellDelegator Methods
    
    func callSegueFromButtonCell(url url: String) {
        performSegueWithIdentifier(SEGUE_WEB_VC, sender: url)
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
        if segue.identifier == SEGUE_DETAILS_VC {
            if let detailsVC = segue.destinationViewController as? DetailsVC {
                if let movie = sender as? Movie {
                    detailsVC.movie = movie
                }
            }
        }
    }


}
