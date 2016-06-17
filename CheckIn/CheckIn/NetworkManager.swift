//
//  NetworkManager.swift
//  CheckIn
//
//  Created by Kevin Zeckser on 6/16/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

import Foundation

final class SlackRequestManager {
    
    // MARK: - Properties
    
    static let sharedInstance = SlackRequestManager()
    private let basePath = "https://hooks.slack.com/services"
    private let session: NSURLSession!
    private init() {
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: sessionConfig)
    }

    // MARK: - NSURLRequest & JSON POST
    
    
    
    
}
