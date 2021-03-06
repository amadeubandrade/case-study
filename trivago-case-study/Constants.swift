//
//  Constants.swift
//  trivago-case-study
//
//  Created by Amadeu Andrade on 28/07/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import Foundation

//MARK: - Completion Handler
typealias downloadCompleted = (success: Bool) -> ()

//MARK: - Keys
let KEY_TRAKT = "ad005b8c117cdeee58a1bdb7089ea31386cd489b21e14b19818c91511f12a086"

//MARK: - URLs
let URL_BASE = "https://api.trakt.tv/"

//MARK: - Segues
let SEGUE_SEARCH_VC = "showSearchVC"
let SEGUE_WEB_VC = "showWebVC"
let SEGUE_DETAILS_VC = "showDetailsVC"

//MARK: - Requests
let REQUEST_PAGE_LIMIT = 10
let REQUEST_HEADER = [
    "Content-Type": "application/json",
    "trakt-api-version": "2",
    "trakt-api-key": KEY_TRAKT
]
let REQUEST_CONTENT_TYPE = ["image/jpeg", "image/gif", "image/png"]
