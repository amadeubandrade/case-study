//
//  SearchVC.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 31/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate {
    
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
        
        //test data:
        let movie1 = Movie(name: "DEADPOOL", year: "2016", overview: "Based upon Marvel Comics’ most unconventional anti-hero, DEADPOOL tells the origin story of former Special Forces operative turned mercenary Wade Wilson, who after being subjected to a rogue experiment that leaves him with accelerated healing powers, adopts the alter ego Deadpool. Armed with his new abilities and a dark, twisted sense of humor, Deadpool hunts down the man who nearly destroyed his life.", youtubeUrl: "https://www.youtube.com/watch?v=Q9X-bAE8KTc")
        let movie2 = Movie(name: "Batman: The Dark Knight", year: "2008", overview: "Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and District Attorney Harvey Dent, Batman sets out to dismantle the remaining criminal organizations that plague the streets. The partnership proves to be effective, but they soon find themselves prey to a reign of chaos unleashed by a rising criminal mastermind known to the terrified citizens of Gotham as the Joker.", youtubeUrl: "https://www.youtube.com/watch?v=EXeTwQWrcwY")
        filteredMovies.append(movie1)
        filteredMovies.append(movie2)
    }


}
