//
//  SafaryActivity.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 19/07/15.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit

class SafaryActivity: UIActivity {
    
    var url: NSURL!
    
    override func activityType() -> String? {
        return "SafaryActivity"
    }
    
    override func activityImage() -> UIImage? {
        let image: UIImage = UIImage(named: "safari")!
        return image
    }
    
    override func activityTitle() -> String? {
        return "Open in Safari"
    }
    
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        
        for activityItem in activityItems{
            if ((activityItem.isKindOfClass(NSURL)) && UIApplication.sharedApplication().canOpenURL(activityItem as! NSURL)){
                return true
            }
        }
        
        return false
    }
    
    override func prepareWithActivityItems(activityItems: [AnyObject]) {
        
        for activityItem in activityItems {
            if ((activityItem.isKindOfClass(NSURL)) && UIApplication.sharedApplication().canOpenURL(activityItem as! NSURL)){
                url = activityItem as! NSURL
            }
        }
    }
    
    override func performActivity() {
        
        var completed: Bool = false
        
        if (url != nil){
            completed = UIApplication.sharedApplication().openURL(url)
        }
        
        activityDidFinish(completed)
    }
    

}
