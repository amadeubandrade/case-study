//
//  SearchVC.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 31/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import Alamofire

class SearchVC: UIViewController, UISearchBarDelegate {
    
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


}
