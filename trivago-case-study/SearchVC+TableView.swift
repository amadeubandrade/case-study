//
//  SearchVC+TableView.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 31/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

extension SearchVC: UITableViewDelegate, UITableViewDataSource, MyCustomCellDelegator {

    //MARK: - Table View Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("SearchMovieCell") as? SearchMovieCell {
            let movie = filteredMovies[indexPath.row]
            cell.configureCell(movie)
            cell.delegate = self
            return cell
        }
        return SearchMovieCell()
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
    }
    

}