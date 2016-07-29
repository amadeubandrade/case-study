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
    private var _overview: String!
    private var _imageUrl: String?
    private var _fanArtUrl: String?
    
    
    //MARK: - Getters
    
    var name: String {
        return _name
    }
    
    var year: String {
        return _year
    }
    
    var overview: String {
        return _overview
    }
    
    var imageUrl: String? {
        return _imageUrl
    }
    
    var fanArtUrl: String? {
        return _fanArtUrl
    }
    
    
    //MARK: - Initializer
    
    init(name: String, year: String, overview: String, imageUrl: String?, fanArtUrl: String?) {
        _name = name
        _year = year
        _overview = overview
        if let image = imageUrl {
            _imageUrl = image
        }
        if let fanArt = fanArtUrl {
            _fanArtUrl = fanArt
        }
    }
    
}