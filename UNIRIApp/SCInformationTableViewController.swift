//
//  SCInformationTableViewController.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 26/11/2015.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit

class SCInformationTableViewController: UITableViewController {
    
    /**********************************************************************************************************/
    //MARK: - IBOutlet
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    /**********************************************************************************************************/
    //MARK: - Variable init/decl
    
    let infoList = ["Podstanarkse subvencije", "Poslovi preko SC"]
    
    /**********************************************************************************************************/
    //MARK: - Main

    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: Navigation Bar and background color setup
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
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "worksSC"{
            let instance: DocumentReaderViewController = segue.destinationViewController as! DocumentReaderViewController
            instance.sendTitle = "Informacije"
            instance.documentName = "posloviSC"
        }
        else if segue.identifier == "roomrerSubvention"{
            let instance: DocumentReaderViewController = segue.destinationViewController as! DocumentReaderViewController
            instance.sendTitle = "Informacije"
            instance.documentName = "subvencije"
        }
    }
}
