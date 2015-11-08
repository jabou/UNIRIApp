//
//  FoodViewController.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 19/07/15.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /**********************************************************************************************************/
    //MARK: - IBOutlets
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    /**********************************************************************************************************/
    //MARK: - Variable init/decl
    
    let objectNameData = ["Restoran \"Index\"","Restoran \"Kampus\"","Restoran \"Mini\"","Bistro \"Mul\"","Bistro \"Pravri\"","Bistro \"Riteh\"","Caffe bar \"Infuzija\"","Caffe bar \"UNIRI\"","Caffe bar \"Formula\"","Caffe bar \"Akvarij\"","Caffe bar \"Medicinar\"","Caffe bar \"Reful\"","Caffe bar \"Andrea\""]
    let objectPictureData = ["RIndex","RKampus","RMini","BMul","BPravri","BRiteh","CInfuzija","CUniri","CFormula","CAkvarij","CMedicinar","CReful","CAndrea"]
    let objectAdressData = ["Krešimirova 12","Radmile Matejčić 5","Franje Čandeka 4","Primorksa ulica 42, Opatija","Hahlić 6","Vukovarska 58","Viktora Cara Emina 5","Trg braće Mažuranić 19","Radmile Matejčić 2","Radmile Matejčić 5","Braće Branchetta 20","Sveučilišna Avenija 4","Radmile Matejčić 3"]
    let objectWorkTimeData = ["pon-pet: 07:00-21:00h  sub: 10:00-21:00h  ned: 13:00-21:00h","pon-pet: 11:00-18:30h","pon-pet: 07:00-21:00  ned: 07:00-21:00","pon-pet: 07:30-17:00","pon-pet: 07:30-17:00","pon-pet: 07:30-14:30","pon-pet: 07:30-14:30","pon-pet: 07:30-15:00","pon-pet: 07:30-14:00","pon-pet: 07:30-16:00","pon-pet: 07:30-16:00","pon-pet: 07:30-16:00","pon-pet: 07:30-14:00"]

    /**********************************************************************************************************/
    //MARK: - Main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Navigation Bar Setup and main menu setup
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
        
        //MARK: table view
        tableView.delegate = self
        tableView.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**********************************************************************************************************/
    //MARK: - TableView setup
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectNameData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("foodCell", forIndexPath: indexPath) as! FoodTableViewCell
        
        cell.objectTitle.text = objectNameData[indexPath.row]
        cell.objectImage.image = UIImage(named: objectPictureData[indexPath.row])
        cell.objectAdress.text = objectAdressData[indexPath.row]
        cell.objectWorktime.text = objectWorkTimeData[indexPath.row]
        
        return cell
    }
}
