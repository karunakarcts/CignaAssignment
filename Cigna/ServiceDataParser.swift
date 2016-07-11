//
//  ServiceDataParser.swift
//  Cigna
//
//  Created by Karunakar Bandikatla on 7/11/16.
//  Copyright © 2016 Cognizant. All rights reserved.
//

import Foundation
import UIKit


class ServiceDataParser{
    
    
    static func parseSeasonData(data: NSData!, callback: (NSArray!, NSError!) -> Void) {
        
        
        do {
            
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? NSDictionary
            
            var episodesArr = [Episode]()

            if let episodes = json!["Episodes"] as? [[String: AnyObject]] {
                
                for episode in episodes {
                    
                    let title = episode["Title"] as? String
                    let episodeNo = episode["Episode"] as? String
                    let released = episode["Released"] as? String
                    let imdbID = episode["imdbID"] as? String
                    let imdbRating = episode["imdbRating"] as? String
                    
                    let episodeModel : Episode = Episode(title: title!, imdbID: imdbID!, released: released!, imdbRating: imdbRating!, episodeNumber: episodeNo!)
                    
                    episodesArr.append(episodeModel)
                    
                }
                callback(episodesArr,nil)
            }
        }
            
        catch {
            print("error serializing JSON: \(error)")
            //callback(nil,NSError.init(domain: "", code: 100, userInfo: ))
        }
        
    }
    
    static func parseEpisodeData(data: NSData!, callback: (NSDictionary!, NSError!) -> Void) {
        
        
        do {
            
            let episodeInfo = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? NSDictionary
            
             callback(episodeInfo,nil)
        
        }
            
        catch {
            print("error serializing JSON: \(error)")
            //callback(nil,NSError.init(domain: "", code: 100, userInfo: ))
        }
        
    }
    
    
    
}


