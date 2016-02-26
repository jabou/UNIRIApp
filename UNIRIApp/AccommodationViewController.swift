//
//  AccommodationViewController.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 26/11/2015.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit

class AccommodationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /**********************************************************************************************************/
    //MARK: - IBOutlet
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    
    /**********************************************************************************************************/
    //MARK: - Variable init/decl
    
    let accomodationNames = ["Studentsko naselje \"I. G. Kovačić\""]
    let accomodationAdress = ["Franje Čandeka 4"]
    let accomodationMasters = ["051/671-002"]
    let accomodationPictures = ["IGKStudentskiDom"]

    /**********************************************************************************************************/
    //MARK: - Main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - Navigation Bar Setup and main menu setup
        //self.title = "Smještaj"
        self.navigationController?.navigationBar.translucent = false
        self.view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        
        //MARK: -Functionality for menu button (open/close)
        if self.revealViewController() != nil{
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        //MARK: -Enable tap and pan gesture while side menu is open
        let openMenuGesture: SWRevealViewController = self.revealViewController()
        openMenuGesture.panGestureRecognizer()
        openMenuGesture.tapGestureRecognizer()
        
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    /**********************************************************************************************************/
    //MARK: - TableView setup
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accomodationNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("accomodationCell", forIndexPath: indexPath) as! AccomodationTableViewCell
        
        cell.accomodationTitle.text = accomodationNames[indexPath.row]
        cell.accomodationAdress.text = accomodationAdress[indexPath.row]
        cell.accomodationMaster.text = accomodationMasters[indexPath.row]
        cell.accomodationPicture.image = UIImage(named: accomodationPictures[indexPath.row])
        
        return cell

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
