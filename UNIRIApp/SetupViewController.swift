//
//  SetupViewController.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 08/11/2015.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit
import CoreData

class SetupViewController: UIViewController {
    
    /**********************************************************************************************************/
    //MARK: - Variable init
    
    var facultyList: NSArray!
    var choosenName: String!
    
    /**********************************************************************************************************/
    //MARK: - IBOutlet
    
    @IBOutlet weak var saveButton: UIButton!
    
    /**********************************************************************************************************/
    //MARK: - Connection with CoreData
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    /**********************************************************************************************************/
    //MARK: - Main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Connection with FacultyList
        let url = NSBundle.mainBundle().URLForResource("FacultyList", withExtension: "plist")
        facultyList = NSArray(contentsOfURL: url!) as! Array<String>
        
        //MARK: Change colors
        self.view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        self.saveButton.tintColor = UIColor(red: 4/255, green: 79/255, blue: 132/255, alpha: 1.0)
        
        //initiali hide "save" button and status bar
        self.saveButton.hidden = true
        UIApplication.sharedApplication().statusBarHidden = true
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        //MARK: bring back status bar
        UIApplication.sharedApplication().statusBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**********************************************************************************************************/
    //MARK: - Setup PickerView
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title: AnyObject = facultyList[row]
        let customPicker = NSAttributedString(string: title as! String, attributes: [NSFontAttributeName:UIFont(name: "Avenir-Book", size: 15.0)!,NSForegroundColorAttributeName:UIColor(red: 4/255, green: 79/255, blue: 132/255, alpha: 1.0)])
        customPicker
        return customPicker
    }
    
    func numberOfComponentsInPickerView(collagePicker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(collagePicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return facultyList.count
    }
    
    func pickerView(collagePicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String{
        return facultyList[row] as! String
    }
    
    func pickerView(collagePicker: UIPickerView!, didSelectRow row: Int, inComponent component: Int){
        
        if row == 0{
            self.saveButton.hidden = true
        }
        else{
            self.saveButton.hidden = false
            choosenName = pickerView(collagePicker, titleForRow: collagePicker.selectedRowInComponent(0), forComponent: 0)
        }
    }
    
    
    /**********************************************************************************************************/
    //MARK: - IBAction
    
    @IBAction func saveButton(sender: AnyObject) {
        
        //MARK: connect to database
        let fetchRequest = NSFetchRequest(entityName: "UserData")
        
        do{
            let fetch = try managedObjectContext?.executeFetchRequest(fetchRequest)
            
            if fetch!.isEmpty == true{
                
                let newItem = NSEntityDescription.insertNewObjectForEntityForName("UserData", inManagedObjectContext: self.managedObjectContext!) as! Model
                
                newItem.chosenFaculty = choosenName
                
                do {
                    try managedObjectContext?.save()
                } catch {
                    print("Data was not saved!")
                }
            }
        } catch {
            print("Error with fetching data for save button")
        }
        
        //Change NSUserDefaults value "hasSetupApp" to "true" so that this window will not appear again
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "hasSetupApp")
        
        //Open main view
        if let mainViewController = storyboard?.instantiateViewControllerWithIdentifier("main") as? SWRevealViewController{
            presentViewController(mainViewController, animated: true, completion: nil)
        }
    }
}
