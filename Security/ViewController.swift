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
        
        // For use in foreground (since already covered all the time)
        //self.locationManager.requestWhenInUseAuthorization()
        
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
    
    
    @IBAction func tester(sender: AnyObject) {
        echoTest()
    }
    
    func echoTest(){
        var messageNum = 0
        let ws = WebSocket("ws://localhost:8080")
        let send : ()->() = {
            let msg = "\(++messageNum): \(NSDate().description)"
            print("send: \(msg)")
            ws.send(msg)
        }
        ws.event.open = {
            print("opened")
            send()
        }
        ws.event.close = { code, reason, clean in
            print("close")
        }
        ws.event.error = { error in
            print("error \(error)")
        }
    }


}



