//
//  SpinIndicator.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 01/08/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class SpinIndicator {
    
    //MARK: - Properties
    
    var indicator: UIActivityIndicatorView!
    
    
    //MARK: - Initializer
    
    init() {
        indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    }
    
    
    //MARK: - Functions
    
    func startSpinning(view: UIView) {
        indicator.color = UIColor.blackColor()
        indicator.frame = CGRectMake(0.0, 0.0, 10.0, 10.0)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.bringSubviewToFront(view)
        indicator.startAnimating()
    }
    
    func stopSpinning() {
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }
    
}