//
//  SARequestManager.swift
//  SpotifyArtistsViewer
//
//  Created by Kevin Zeckser on 6/6/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//
import Foundation

enum SAResponse {
    case Success(artists: [SAArtist])
    case Failure(error: ErrorType)
}


final class SARequestManager {
    
    // MARK: - Properties
    
    static let sharedInstance = SARequestManager()
    private let session: NSURLSession!
    // This prevents others from using the default '()' initializer for this class.
    private init() {
        let sessionConfig: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: sessionConfig)
    }
    
    // MARK: - NSURLRequest & JSON Parse
    
    func getArtistsWithQuery(query: String, completion: SAResponse -> Void) {
        let path = "https://api.spotify.com/v1/search?q=\(query)&type=track,artist&market=US"
        guard let url = NSURL(string: path) else { return }
        
        let task = session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            var result: SAResponse
            
            // We have to handle a few cases here:
            
            if let error = error {
                // 1. Something went wrong with the request. We pass along the error.
                result = SAResponse.Failure(error: error)
            } else if let data = data {
                
                do {
                    let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    var returnedArtists = [SAArtist]()
                    
                    if let artistResponse = jsonResult?["artists"], let artists = artistResponse["items"] as? NSArray {
                        for entry in artists {
                            let artistEntry = entry as? NSDictionary
                            guard let name = artistEntry?["name"] as? String else { continue }
                            guard let images = artistEntry?["images"] as? NSArray else { continue }
                            guard let image = self.fetchImage(images as [AnyObject]) else { continue }
                            
                            // TODO: Load a description
                            // let description: String?
                            returnedArtists.append(SAArtist(name: name, image: image, description: nil))
                        }
                    }
                
                    result = SAResponse.Success(artists: returnedArtists)
                } catch let error as NSError {
                    result = SAResponse.Failure(error: error)
                }
            } else {
                result = SAResponse.Success(artists: [SAArtist]())
            }
            // Call our completion handler on the main queue
            dispatch_async(dispatch_get_main_queue()) {
                completion(result)
            }
        }
        task.resume()
        
    }
 
    
    func fetchImage(images: [AnyObject]?) -> String?  {
        // take an array of strings, determine which is best for the job
        guard let images = images else { return nil }
        
        for image in images {
            
            guard ((image as? [String:AnyObject]) != nil) else {
                return nil
            }
            
            if let imageDict = image as? [String:AnyObject] {
                if let height = imageDict["height"] as? Int, let width = imageDict["width"] as? Int {
                    if height == width {
                        if let url = image["url"] as? String {
                            return url
                        }
                    }
                }
            }

        }
        return nil
    }
}