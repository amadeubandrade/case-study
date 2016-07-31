//
//  SearchVC.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 31/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties
    
    var filteredMovies = [Movie]()
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = .Done
    }

    //MARK: - Table View Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
 
    //MARK: - Search Bar Methods
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }

}
