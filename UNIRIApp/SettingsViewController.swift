//
//  SettingsViewController.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 08/11/2015.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {
    
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
        
        //MARK: Navigation Bar Setup
        self.navigationController?.navigationBar.translucent = false
        self.title = "Promijeni fakultet"
        
        //MARK: Change colors
        self.view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        self.saveButton.tintColor = UIColor(red: 4/255, green: 79/255, blue: 132/255, alpha: 1.0)
        
        //MARK: Initially remove button
        self.saveButton.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**********************************************************************************************************/
    //MARK: - Setup PickerView
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title: AnyObject = facultyList[row]
        let customPicker = NSAttributedString(string: title as! String, attributes: [NSFontAttributeName:UIFont(name: "Avenir-Book", size: 15.0)!,NSForegroundColorAttributeName: UIColor(red: 4/255, green: 79/255, blue: 132/255, alpha: 1.0)])
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
    //MARK: - Save faculty change
    
    @IBAction func saveButton(sender: AnyObject) {
        
        //MARK: connect to database
        let fetchRequest = NSFetchRequest(entityName: "UserData")
        
        do{
            let fetch = try managedObjectContext?.executeFetchRequest(fetchRequest)
            
            if fetch!.isEmpty == false{
                do {
                    if let allData = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [Model]{
                        let existingItem: NSManagedObject = allData[0]
                        existingItem.setValue(choosenName, forKey: "chosenFaculty")
                        
                        //Save changes
                        try managedObjectContext!.save()
                    }
                } catch {
                        print("Data was not saved!")
                }
            }
            
        } catch {
            print("Error fetching data for save")
        }

        //MARK: Close View
        closeView()
    }
    
    /**********************************************************************************************************/
    //MARK: - Close Settings View
    @IBAction func cancelButton(sender: AnyObject) {
        closeView()
    }

    func closeView(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
