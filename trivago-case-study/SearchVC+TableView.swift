//
//  SearchVC+TableView.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 31/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

extension SearchVC: UITableViewDelegate, UITableViewDataSource {

    //MARK: - Table View Methods
    
    //MARK: Number of sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    //MARK: Number of rows per section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    
    //MARK: Cell configurations
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("SearchMovieCell") as? SearchMovieCell {

            if filteredMovies.count != 0 {
                let movie = filteredMovies[indexPath.row]
                
                if indexPath.row == filteredMovies.count - 1 {
                    spinLoadingMovies.startAnimating()
                    actualPageNumber += 1
                    downloadSearchedMovies(textToSearch!, pageNumber: actualPageNumber, completed: { (success) in
                        self.spinLoadingMovies.stopAnimating()
                        self.tableView.reloadData()
                    })
                }
                cell.posterRequest?.cancel()
                cell.configureCell(movie)
                cell.delegate = self
                return cell
            } else {
                return SearchMovieCell()
            }
        }
        return SearchMovieCell()
    }
    
    
    //MARK: Cell selection
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let movie = filteredMovies[indexPath.row]
        performSegueWithIdentifier(SEGUE_DETAILS_VC, sender: movie)
    }
    

}