//
//  DetailViewController.swift
//  Cigna
//
//  Created by Karunakar Bandikatla on 7/11/16.
//  Copyright © 2016 Cognizant. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    
    var episodeItem: Episode? {
        
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        
        // Update the user interface for the detail item.
        
        if let detail = self.episodeItem {
            
            self.navigationItem.title = detail.title
            
            if Reachability.isConnectedToNetwork() == false {
                
                self.showAlert("Your device is not having internet connection!")
                return
            }
            
            ServicesAPI.getEpisodeData(detail.imdbID, callback: {
                
                (episodeInfo, error) in
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if self.yearLabel != nil {
                        
                        self.yearLabel.text = episodeInfo.objectForKey("Year") as? String
                    }
                    
                    if self.ratedLabel != nil {
                        
                        self.ratedLabel.text = episodeInfo.objectForKey("Rated") as? String
                    }
                    
                    if self.releasedLabel != nil {
                        
                        self.releasedLabel.text = episodeInfo.objectForKey("Released") as? String
                    }
                    
                    if self.seasonLabel != nil {
                        
                        self.seasonLabel.text = episodeInfo.objectForKey("Season") as? String
                    }
                    
                    if self.episodeLabel != nil {
                        
                        self.episodeLabel.text = episodeInfo.objectForKey("Episode") as? String
                    }
                    
                    if self.runTimeLabel != nil {
                        
                        self.runTimeLabel.text = episodeInfo.objectForKey("Runtime") as? String
                    }
                    
                    
                }
                
                
            })

        }
        
    }    
   

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.configureView()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(message:NSString){
        
        let alertView = UIAlertController(title: "", message: message as String, preferredStyle: .Alert)
        
        
        let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        alertView.addAction(okAction)
        
        self.presentViewController(alertView, animated: true, completion: nil)
        
    }


}

