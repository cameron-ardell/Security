//
//  ViewController.swift
//  Security
//
//  Created by Sophie Ardell on 1/29/16.
//  Copyright © 2016 Sophie Ardell. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let phoneNum = "6175290037"
    
    override func viewDidLoad() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            
            //is a level of accuracy within 10 meters okay? considering people using
            //this at night when battery low, worried to go
            
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    @IBAction func stoplight(sender: UIButton) {
        
        let color = sender.currentTitle!
        
        switch color{
            //leave yellow for last
        case "Red":
            self.callNumber(phoneNum)
        default:
            print("is this working")
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        
        let locValLatitude: CLLocationDegrees = locValue.latitude
        let locValLongitude: CLLocationDegrees = locValue.longitude
        
        //find a way to send this to a website soon
        
        print("locations = \(locValLatitude) \(locValLongitude)")
    }

    
    //Cory's code
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
    
    
    
    //trying to send stuff
    @IBAction func submitAction(sender: AnyObject) {
        
        //var parameter = ["name" : nametextField.text, "ID": idtextField.text]
        let parameters = ["test phrase":"Hello world"]
        
        
        //create the url to send things to
        let url = NSURL(string: "http://servename.com/api")
        
        //created object for session
        let session = NSURLSession.sharedSession()
        
        //now making request using the url object
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST" //set http method as POST
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        

        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: [])
        } catch {
            print(error)
        }// pass dictionary to nsdata object and set it as request body
        
        
        let task = session.dataTaskWithRequest(request) { data, response, error in guard data != nil else {
                print("no data found: \(error)")
                return
            }
            
            // fails easily if server error
            do {
                if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    let success = json["success"] as? Int                                  // Okay, the `json` is here, let's get the value for 'success' out of it
                    print("Success: \(success)")
                } else {
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)    // No error thrown, but not NSDictionary
                    print("Error could not parse JSON: \(jsonStr)")
                }
            } catch let parseError {
                print(parseError)                                                          // Log the error thrown by `JSONObjectWithData`
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
            }
        }
        
        task.resume()
        
    }
    


}



