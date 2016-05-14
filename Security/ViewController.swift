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
    var phoneNumber: String?
    var studentID: String?
    var fullName: String?
    var traveling: Bool = false
    var status: Int = 0
    var timer = NSTimer()
    var counter = 0
    
    //replace when convenient
    let securityNumber = "6175290037"
    
    
    
    
    override func viewDidLoad() {
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        startLocationTracking()

        
<<<<<<< HEAD
        //UIApplication.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Sound.union(.Alert).union(.Badge), categories: nil))
=======
        // For use in foreground (since already covered all the time)
        //self.locationManager.requestWhenInUseAuthorization()
>>>>>>> origin/master
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        phoneNumber = defaults.stringForKey("phoneNumber")
        studentID = defaults.stringForKey("studentID")
        fullName = defaults.stringForKey("fullName")
       
        if phoneNumber == nil{
            self.performSegueWithIdentifier("login", sender: nil)
            
        }

    }
    
    @IBAction func logOut(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("phoneNumber")
        defaults.removeObjectForKey("studentID")
        defaults.removeObjectForKey("fullName")
        
        self.performSegueWithIdentifier("login", sender: nil)
        
    }
    
    @IBAction func stoplight(sender: UIButton) {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        UIApplication.sharedApplication().idleTimerDisabled = false
        timer.invalidate()
        countdown.text = ""
        
        let color = sender.currentTitle!
        
        switch color{
        
        case "Red":

            traveling = true
            status = 1
            
            if phoneNumber != nil{
                self.callNumber()
                //print(phoneNumber!)
            }
        case "Yellow":
            //timer.invalidate()
            traveling = true
            status = 2
            counter = 0
            UIApplication.sharedApplication().idleTimerDisabled = true
            
            
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            
            let notification = UILocalNotification()
            notification.alertBody = "Tap yellow button in next 2 minutes to extend your journey."
            notification.alertTitle = "Are you okay?"
            notification.fireDate = NSDate(timeIntervalSinceNow: 20*1)
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            
            let second_notification = UILocalNotification()
            second_notification.alertBody = "Calling security."
            second_notification.alertTitle = "Calling security."
            second_notification.fireDate = NSDate(timeIntervalSinceNow: 30*1)
            UIApplication.sharedApplication().scheduleLocalNotification(second_notification)
            
            
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: ("updateCounter"), userInfo: nil, repeats: true)
            
            
            
        case "Green":
            traveling = true
            status = 3
            //startLocationTracking()
        
        
        case "OFF":
            timer.invalidate()
            traveling = false
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            UIApplication.sharedApplication().idleTimerDisabled = false
            
            countdown.text = ""
            //color = ""
            
        
        default:
            print("is this working")
        }
        
    }
    
    @IBOutlet weak var countdown: UILabel!
    
    
    func updateCounter(){
        counter++
        //print("whyyyyy")
        
        countdown.text = "\(10*60 - Int(counter)) s"
        
        if counter == 30{
            callNumber()
            timer.invalidate()
            counter = 0
        }
    }
    
    func startLocationTracking(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }

    }
    
    
    //Cory's code
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        
        let locValLatitude: CLLocationDegrees = locValue.latitude
        let locValLongitude: CLLocationDegrees = locValue.longitude
        
        print("locations = \(locValLatitude) \(locValLongitude)")
        
        if traveling == true {
            //echoTest(locValLatitude, longitude:locValLongitude)
            print("yeeeeeee")
        }
    }
    
    
    private func callNumber() {
        let phoneNumber = "6175290037"
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
    
    func echoTest(latitude:Double, longitude:Double){
        let ws = WebSocket("ws://localhost:8080")
        let send : ()->() = {
            let msg: [Any]=[latitude,longitude,self.fullName!, self.status]
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
<<<<<<< HEAD
=======


>>>>>>> origin/master
}



