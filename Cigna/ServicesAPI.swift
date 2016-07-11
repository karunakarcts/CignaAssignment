//
//  ServicesAPI.swift
//  Cigna
//
//  Created by Karunakar Bandikatla on 7/11/16.
//  Copyright © 2016 Cognizant. All rights reserved.
//

import Foundation
import UIKit


class ServicesAPI{
    
    
    static func getSeasonData(seasonNumber: Int!, callback: (NSArray!, NSError!) -> Void) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        var dataTask: NSURLSessionDataTask?
    
        let url = NSURL(string: "http://www.omdbapi.com/?t=Game%20of%20Thrones&Season=\(seasonNumber)")
    
        dataTask = defaultSession.dataTaskWithURL(url!) {
            
            data, response, error in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
            }
            
            if let error = error {
                
                callback(nil, error)
                
            }
            
            else if let httpResponse = response as? NSHTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    
                    ServiceDataParser.parseSeasonData(data, callback: {
                        
                        (episodes, error) in
                        
                        callback(episodes,error)
                        
                    })
                    
                    
                }
                
                else{
                    
                    callback(nil, error)
                    
                }
                
            }
            
        }
        
          dataTask?.resume()
        
        
       }
    
    static func getEpisodeData(episodeimdbID: String!, callback: (NSDictionary!, NSError!) -> Void) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        var dataTask: NSURLSessionDataTask?
        
        let url = NSURL(string: "http://www.omdbapi.com/?i=\(episodeimdbID)&plot=short&r=json")
        
        dataTask = defaultSession.dataTaskWithURL(url!) {
            
            data, response, error in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
            }
            
            if let error = error {
                
                callback(nil, error)
                
            }
                
            else if let httpResponse = response as? NSHTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    
                    ServiceDataParser.parseEpisodeData(data, callback: {
                        
                        (episodes, error) in
                        
                        callback(episodes,error)
                        
                    })
                    
                    
                }
                    
                else{
                    
                    callback(nil, error)
                    
                }
                
            }
            
        }
        
        dataTask?.resume()
        
        
    }
    
}


