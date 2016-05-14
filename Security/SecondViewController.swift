//
//  SecondViewController.swift
//  Security
//
//  Created by Sophie Ardell on 1/30/16.
//  Copyright © 2016 Sophie Ardell. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SecondViewController: UIViewController {

   
    @IBOutlet weak var fullName: UITextField!
    
    @IBOutlet weak var studentID: UITextField!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    
    @IBAction func save() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(fullName.text!, forKey: "fullName")
        defaults.setValue(studentID.text!, forKey: "studentID")
        defaults.setValue(phoneNumber.text!, forKey: "phoneNumber")
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        //print("Full Name=\(fullName.text!)")
        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
