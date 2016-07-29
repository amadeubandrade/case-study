//
//  Movie.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 29/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class Movie {

    //MARK: - Properties
    
    private var _name: String!
    private var _year: String!
    private var _overview: String?
    private var _posterUrl: String?
    private var _bannerUrl: String?
    private var _imdbUrl: String?
    private var _youtubeUrl: String?
    private var _homepageUrl: String?
    
    
    //MARK: - Getters
    
    var name: String {
        return _name
    }
    
    var year: String {
        return _year
    }
    
    var overview: String? {
        return _overview
    }
    
    var posterUrl: String? {
        return _posterUrl
    }
    
    var bannerUrl: String? {
        return _bannerUrl
    }
    
    var imdbUrl: String? {
        return _imdbUrl
    }
    
    var youtubeUrl: String? {
        return _youtubeUrl
    }
    
    var homepageUrl: String? {
        return _homepageUrl
    }
    
    
    //MARK: - Initializer
    
    init(name: String, year: String, overview: String? = nil, posterUrl: String? = nil, bannerUrl: String? = nil, imdbUrl: String? = nil, youtubeUrl: String? = nil, homepageUrl: String? = nil) {
        _name = name
        _year = year
        if let overviewTxt = overview {
            _overview = overviewTxt
        }
        if let poster = posterUrl {
            _posterUrl = poster
        }
        if let banner = bannerUrl {
            _bannerUrl = banner
        }
        if let imdb = imdbUrl {
            _imdbUrl = imdb
        }
        if let youtube = youtubeUrl {
            _youtubeUrl = youtube
        }
        if let homepage = homepageUrl {
            _homepageUrl = homepage
        }
        
    }
    
}