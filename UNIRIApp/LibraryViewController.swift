//
//  LibraryViewController.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 06/01/16.
//  Copyright © 2016 Jasmin Abou Aldan. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    /**********************************************************************************************************/
     //MARK: - IBOutlet
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var libraryAdress: UILabel!
    @IBOutlet weak var libraryTelephoneNumber: UILabel!
    @IBOutlet weak var libraryEmail: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //MARK: Navigation Bar Setup and main menu setup
        self.title = "Knjižnica"
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
        let navigationAlert: UIAlertController = UIAlertController(title: "Pokretanje navigacije", message: "Želiš li pokrenuti navigaciju do:\n \(libraryAdress.text!)", preferredStyle: UIAlertControllerStyle.Alert)
        navigationAlert.addAction(UIAlertAction(title: "Da", style: UIAlertActionStyle.Default, handler: nil))
        navigationAlert.addAction(UIAlertAction(title: "Ne", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(navigationAlert, animated: true, completion: nil)
    }
    
    @IBAction func phoneCall(sender: AnyObject) {
        let navigationAlert: UIAlertController = UIAlertController(title: "Uspostava poziva", message: "Želiš li nazvati broj: \n \(libraryTelephoneNumber.text!)", preferredStyle: UIAlertControllerStyle.Alert)
        navigationAlert.addAction(UIAlertAction(title: "Da", style: UIAlertActionStyle.Default, handler: nil))
        navigationAlert.addAction(UIAlertAction(title: "Ne", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(navigationAlert, animated: true, completion: nil)
    }
    
    @IBAction func mailSend(sender: AnyObject) {
        let navigationAlert: UIAlertController = UIAlertController(title: "Slanje e-mail poruke", message: "Želiš li poslati e-mail na:\n \(libraryEmail.text!)", preferredStyle: UIAlertControllerStyle.Alert)
        navigationAlert.addAction(UIAlertAction(title: "Da", style: UIAlertActionStyle.Default, handler: nil))
        navigationAlert.addAction(UIAlertAction(title: "Ne", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(navigationAlert, animated: true, completion: nil)
    }

}
