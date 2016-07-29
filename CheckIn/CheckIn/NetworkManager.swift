//
//  NetworkManager.swift
//  CheckIn
//
//  Created by Kevin Zeckser on 6/16/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

import Foundation

enum SlackResponse {
    case Success
    case Failure(error: ErrorType)
}

final class SlackRequestManager {
    
    // MARK: - Properties
    
    static let sharedInstance = SlackRequestManager()
    private let basePath = "https://hooks.slack.com/services/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"
    private let jsonString = "json=[{\"channel\": \"#whos-here\", \"username\": \"Pendragon\", \"text\": \"Guess who's back, back again.\", \"icon_emoji\": \":new_moon_with_face:\"}'"
    
    private let session: NSURLSession!
    private init() {
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: sessionConfig)
    }

    // MARK: - NSURLRequest & JSON POST
    
    func outboundWebHookSlack(webhookURL: String, completion: SlackResponse -> Void) {
     
        guard let url = NSURL(string: webhookURL) else { return }
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        let postString = "sometext"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) { data, response, error in
        
        
        }.resume()
    }
}
