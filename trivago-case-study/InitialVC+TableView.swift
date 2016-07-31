//
//  InitialVC+TableView.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 28/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

extension InitialVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularMovies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("PopularMovieCell") as? PopularMovieCell {
            let movie = popularMovies[indexPath.row]
            
            if indexPath.row == popularMovies.count - 1 {
                pageNumber += 1
                downloadPopularMovies(pageNumber, completed: { (success) in
                    if success {
                        tableView.reloadData()
                    } else {
                        print("error")
                    }
                })
            }
            
            cell.bannerRequest?.cancel()
            cell.configureCell(movie)
            return cell
        }
        return UITableViewCell()
    }
    
}