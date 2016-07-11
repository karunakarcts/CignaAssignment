//
//  Episode.swift
//  Cigna
//
//  Created by Karunakar Bandikatla on 7/11/16.
//  Copyright © 2016 Cognizant. All rights reserved.
//

import Foundation

class Episode {
    
    // MARK: Properties
    
    var title: String?
    var imdbID:String?
    var released:String?
    var imdbRating : String?
    var episodeNumber :String?
    
    
    init(title: String, imdbID: String, released: String, imdbRating: String, episodeNumber: String) {
        
        self.title = title;
        self.imdbID = imdbID;
        self.released = released;
        self.imdbRating = imdbRating;
        self.episodeNumber = episodeNumber;
    }
    
}