//
//  InitialVC+TableView.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 28/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

extension InitialVC: UITableViewDelegate, UITableViewDataSource {

    //MARK: - Table View Methods
    
    //MARK: Number of sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    //MARK: Number of rows per section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularMovies.count
    }
    
    
    //MARK: Cell configurations
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("PopularMovieCell") as? PopularMovieCell {
            let movie = popularMovies[indexPath.row]
            
            if indexPath.row == popularMovies.count - 1 {
                actualPageNumber += 1
                loadingMoviesIndicator.startAnimating()
                downloadPopularMovies(actualPageNumber, completed: { (success) in
                    if success {
                        tableView.reloadData()
                        self.loadingMoviesIndicator.stopAnimating()
                    } else {
                        self.loadingMoviesIndicator.stopAnimating()
                        let alert = UIAlertController(title: "Problem found", message: "There was a problem with your request. Please try again later.", preferredStyle: .Alert)
                        let action = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
                        alert.addAction(action)
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                })
            }
            cell.configureCell(movie)
            return cell
        }
        return PopularMovieCell()
    }
    
    
    //MARK: Cell Selection
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let movie = popularMovies[indexPath.row]
        performSegueWithIdentifier(SEGUE_DETAILS_VC, sender: movie)
    }
    
    
}