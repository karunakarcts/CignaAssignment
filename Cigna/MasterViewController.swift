//
//  MasterViewController.swift
//  Cigna
//
//  Created by Karunakar Bandikatla on 7/11/16.
//  Copyright © 2016 Cognizant. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var episodes : NSMutableArray?
    var selectedSeasonNumber:Int?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.episodes = NSMutableArray();
        
        self.navigationItem.title = "Game Of Thrones";
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        selectedSeasonNumber = 1;
        
        self.fetchAndDisplaySeason(selectedSeasonNumber!);
        
//        if let split = self.splitViewController {
//
//            let controllers = split.viewControllers
//            
//            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
//        
//        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
    }
    
    func showAlert(message:NSString){
        
        let alertView = UIAlertController(title: "", message: message as String, preferredStyle: .Alert)
        
      
        let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        alertView.addAction(okAction)
        
        self.presentViewController(alertView, animated: true, completion: nil)
   
    }
    
    
    func fetchAndDisplaySeason(seasonNumber:Int) {
        
        if Reachability.isConnectedToNetwork() == false {
           
            self.showAlert("Your device is not having internet connection!")
            return
        }
        
        ServicesAPI.getSeasonData(seasonNumber) { (episodesRef, error) in
            
            self.episodes = episodesRef.mutableCopy() as? NSMutableArray
            
            dispatch_async(dispatch_get_main_queue()) {
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                
                self.tableView.reloadData()
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func reloadSeasonData(sender: AnyObject) {
        
        self.fetchAndDisplaySeason(selectedSeasonNumber!)
        
    }
    
    
    @IBAction func selectSeason(sender: AnyObject) {
        
        let selectSeasonMenu = UIAlertController(title: nil, message: "Select Season", preferredStyle: .ActionSheet)
       
        for i in 1...5 {
            
            let seasonAction = UIAlertAction(title: "Season \(i)", style: .Default, handler: {
                (alert: UIAlertAction!) -> Void in
                
                self.selectedSeasonNumber = i;
                self.fetchAndDisplaySeason(self.selectedSeasonNumber!)
                
                
            })
            
            selectSeasonMenu.addAction(seasonAction)
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        
        selectSeasonMenu.addAction(cancelAction)
        
    
        self.presentViewController(selectSeasonMenu, animated: true, completion: nil)
        
    }
    
    

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetail" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let episode = self.episodes![indexPath.row] as! Episode
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.episodeItem = episode                
//                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//                controller.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
//                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    @IBAction func unwind(segue:UIStoryboardSegue){
        
    }
    

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.episodes?.count)!
       
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let episode = self.episodes![indexPath.row] as! Episode
        
        cell.textLabel!.text = episode.title! as String
        cell.textLabel!.textColor = UIColor(red: 26.0/255.0, green: 77.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        cell.textLabel!.font = UIFont.systemFontOfSize(15)
        
        cell.accessoryType =  UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            
            self.episodes?.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
        
        else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let label : CustomInsetLabel = CustomInsetLabel()
        label.text = "Season \(self.selectedSeasonNumber!)"
        label.textColor = UIColor(red: 26.0/255.0, green: 77.0/255.0, blue: 128.0/255.0, alpha: 1.0);
        label.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 245.0/255.0, alpha: 1.0);
        label.font = UIFont.boldSystemFontOfSize(15);
        
        return label
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 40.0
        
    }


}

