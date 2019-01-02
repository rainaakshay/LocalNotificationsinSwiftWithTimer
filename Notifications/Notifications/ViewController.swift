//
//  ViewController.swift
//  Notifications
//
//  Created by apple on 21/12/18.
//  Copyright © 2018 Seraphic. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController {
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var scheduleButton: UIButton!
    @IBOutlet weak var notificationStatus: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    var notificationTime = Date()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        statusView.isHidden = true
        UNUserNotificationCenter.current().delegate = self
    }
    
    @IBAction func scheduleAction(_ sender: Any) {
        statusView.isHidden = false
        let timeFormat = DateFormatter()
        timeFormat.timeStyle = .short
        notificationTime  = timePicker!.date
        notificationStatus.text! = "Notification is scheduled for " + timeFormat.string(from: notificationTime)
        scheduleNotification(notificationType: "Message")
        
    }
    
    func scheduleNotification(notificationType: String) {
        
        let content = UNMutableNotificationContent()
        
        content.title = notificationType
        content.body = "This is an example"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        var triggerTime = Calendar.current.dateComponents([.hour,.minute,.second], from: notificationTime)
        triggerTime.second = 0
        let notificationtrigger = UNCalendarNotificationTrigger(dateMatching: triggerTime, repeats: false)
        
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: notificationtrigger)
        
        UNUserNotificationCenter.current().add(request){
            (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        
        
    }
    
    
    

}
extension ViewController : UNUserNotificationCenterDelegate
{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound,.badge])
    }
}

