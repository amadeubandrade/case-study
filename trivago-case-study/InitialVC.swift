//
//  ViewController.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 28/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class InitialVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!

    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("PopularMovieCell") as? PopularMovieCell {
            let name = "Batman: The Dark Knight"
            let year = "(2010)"
            cell.configureCell(name, year: year)
            return cell
        }
        return UITableViewCell()
    }


}

