//
//  CacheServices.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 01/08/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class CacheService {

    static let cache = CacheService()
    
    //MARK: - Properties
    
    private var _CACHE = NSCache()
    
    
    //MARK: - Getters
    
    var cache: NSCache {
        return _CACHE
    }
    
    
    //MARK: - Functions
    
    func addToCache(image: UIImage, key: String) {
        _CACHE.setObject(image, forKey: key)
    }
    
    func retrieveFromCache(key: String) -> UIImage? {
        if let image = _CACHE.objectForKey(key) as? UIImage {
            return image
        }
        return nil
    }
    
}