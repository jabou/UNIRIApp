//
//  MainViewController.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 23/05/15.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    /**********************************************************************************************************/
    //MARK: - IBOutlet
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    /**********************************************************************************************************/
    //MARK: - Main

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Navigation Bar Setup and main menu setup
        self.title = "UNIRI"
        self.navigationController?.navigationBar.translucent = false
        self.view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        
        //MARK: Functionality for menu button (open/close)
        if self.revealViewController() != nil{
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        //MARK: Enable tap and pan gesture while side menu is open
        let openMenuGesture: SWRevealViewController = self.revealViewController()
        openMenuGesture.panGestureRecognizer()
        openMenuGesture.tapGestureRecognizer()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**********************************************************************************************************/
    //MARK: - Button actions
    
    @IBAction func navigationStart(sender: AnyObject) {
        let navigationAlert: UIAlertController = UIAlertController(title: "Pokretanje navigacije", message: "Želiš li pokrenuti navigaciju do: Radmile Matejčić 2", preferredStyle: UIAlertControllerStyle.Alert)
        navigationAlert.addAction(UIAlertAction(title: "Da", style: UIAlertActionStyle.Default, handler: nil))
        navigationAlert.addAction(UIAlertAction(title: "Ne", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(navigationAlert, animated: true, completion: nil)
    }

    @IBAction func phoneCall(sender: AnyObject) {
        let navigationAlert: UIAlertController = UIAlertController(title: "Uspostava poziva", message: "Želiš li nazvati broj: +385 51 584 700?", preferredStyle: UIAlertControllerStyle.Alert)
        navigationAlert.addAction(UIAlertAction(title: "Da", style: UIAlertActionStyle.Default, handler: nil))
        navigationAlert.addAction(UIAlertAction(title: "Ne", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(navigationAlert, animated: true, completion: nil)
    }
    
    @IBAction func mailSend(sender: AnyObject) {
        let navigationAlert: UIAlertController = UIAlertController(title: "Slanje e-mail poruke", message: "Želiš li poslati e-mail na: bpglavina@inf.uniri.hr?", preferredStyle: UIAlertControllerStyle.Alert)
        navigationAlert.addAction(UIAlertAction(title: "Da", style: UIAlertActionStyle.Default, handler: nil))
        navigationAlert.addAction(UIAlertAction(title: "Ne", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(navigationAlert, animated: true, completion: nil)
    }
    
    @IBAction func headmasterMail(sender: AnyObject) {
        let navigationAlert: UIAlertController = UIAlertController(title: "Slanje e-mail poruke pročelniku", message: "Želi li poslati e-mail pročelniku na: patrizia@inf.uniri.hr?", preferredStyle: UIAlertControllerStyle.Alert)
        navigationAlert.addAction(UIAlertAction(title: "Da", style: UIAlertActionStyle.Default, handler: nil))
        navigationAlert.addAction(UIAlertAction(title: "Ne", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(navigationAlert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
