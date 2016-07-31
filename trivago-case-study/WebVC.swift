//
//  WebVC.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 31/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import WebKit

class WebVC: UIViewController {
    
    //MARK: - Properties
    
    var webView: WKWebView!
    var urlStr: String!
    

    //MARK: - IBOutlets
    
    @IBOutlet weak var container: UIView!
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        container.addSubview(webView)
    }
    
    override func viewDidAppear(animated: Bool) {
        let frame = CGRectMake(0, 0, container.bounds.width, container.bounds.height)
        webView.frame = frame
        loadRequest(urlStr)
    }
    
    
    //MARK: - Load Request
    
    func loadRequest(url: String) {
        if let urlstr = NSURL(string: urlStr) {
            let request = NSURLRequest(URL: urlstr)
            webView.loadRequest(request)
        }
    }


}
