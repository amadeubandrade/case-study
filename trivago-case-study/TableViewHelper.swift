//
//  TableViewHelper.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 31/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class TableViewHelper {
    
    class func EmptyMessage(message: String, tableView: UITableView) {
        let messageLabel = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width,  tableView.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0)
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .Center;
        messageLabel.font = UIFont(name: "HelveticaNeue", size: 15)
        messageLabel.sizeToFit()
        
        tableView.backgroundView = messageLabel;
        tableView.separatorStyle = .None;
    }
    
}