//
//  MenuViewController.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 08/11/2015.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit
import CoreData

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    /**********************************************************************************************************/
    //MARK: - Variable init and decl with values
    
    let section1Values = ["Stipendije","Studentski centar","Knjižnica"]
    let section1Pictures = ["Stipendije","SCentar","Knjiznice"]
    //let section3Values = ["Zabava","Sport","Kultura","Zdravstvena zaštita","Prijevoz"]
    //let section3Pictures = ["Zabava","Sport","Kultura","ZZastita","Prijevoz"]
    var nameFromDatabase: String!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundPicture: UIImageView!
    @IBOutlet weak var facultyName: UILabel!
    
    /**********************************************************************************************************/
    //MARK: - Connection with CoreData
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    /**********************************************************************************************************/
    //MARK: - Main
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = UIImageView(image: UIImage(named: "MenuBackground"))
    }

    
    override func viewWillAppear(animated: Bool) {
        
        //MARK: Disable Child View interaction when menu is shown
//        self.revealViewController().frontViewController.view.userInteractionEnabled = false
//        self.revealViewController().view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())


        let fetchRequest = NSFetchRequest(entityName: "UserData")
        
        do{
            if let fetch = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [Model]{
                nameFromDatabase = fetch[0].chosenFaculty
            }

        } catch {
            print("Unable to fetch data for Menu View Controller")
        }
        
        changeUI(nameFromDatabase)
        
    }

    override func viewWillDisappear(animated: Bool) {
        //MARK: Enable Child View interaction when menu is shown
//        self.revealViewController().frontViewController.view.userInteractionEnabled = true
        
        //MARK: Clean selection
        if tableView.indexPathForSelectedRow != nil{
            tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**********************************************************************************************************/
    //MARK: - Jump to main window with header picture
    @IBAction func headerButtonForMainWindow(sender: AnyObject) {
        self.performSegueWithIdentifier("mainWindow", sender: nil)
    }
    
    /**********************************************************************************************************/
    //MARK: - Table View Setup
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section{
        case 0:
            return section1Values.count
        case 1:
            return 1 // section3Values.count
//        case 2:
//            return 1
        default:
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //Create View
        let headerView: UIView = UIView()
        headerView.frame = CGRectMake(0, 0, tableView.bounds.size.width, 20)
        
        //Create Label
        let headerLabel: UILabel = UILabel()
        headerLabel.frame = CGRectMake(5, 2, tableView.bounds.size.width, 20)
        headerLabel.font = UIFont.systemFontOfSize(10)
        
        //Fill Label
        switch section{
        case 0:
            headerLabel.text = "OPĆENITO"
        case 1:
            headerLabel.text = "POSTAVKE" //headerLabel.text = "OSTALO"
//        case 2:
//            headerLabel.text = "POSTAVKE"
        default:
            break
        }
        
        //Add Label to View
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Create reusable cell
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) as! CustomTableViewCell
        cell.cellLabel.font = UIFont.systemFontOfSize(16)
        
        //Fill cells
        switch indexPath.section{
        case 0:
            cell.cellLabel.text = section1Values[indexPath.row]
            cell.cellPicture.image = UIImage(named: section1Pictures[indexPath.row])
        case 1:
            cell.cellLabel?.text = "Promijeni fakultet"
            cell.cellPicture.image = UIImage(named: "Postavke")
//            cell.cellLabel?.text = section3Values[indexPath.row]
//            cell.cellPicture.image = UIImage(named: section3Pictures[indexPath.row])
//        case 2:
//            cell.cellLabel?.text = "Promijeni fakultet"
//            cell.cellPicture.image = UIImage(named: "Postavke")
        default:
            break
        }
        
        return cell
    }

    /**********************************************************************************************************/
    //MARK: - Table View Functionality
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                self.performSegueWithIdentifier("scholarship", sender: self)
            case 1:
                self.performSegueWithIdentifier("studentCenter", sender: nil)
            case 2:
                self.performSegueWithIdentifier("library", sender: nil)
            case 3:
                self.performSegueWithIdentifier("erasmus", sender: nil)
            default:
                break
            }
        case 1:
            if indexPath.row == 0{
                self.performSegueWithIdentifier("settings", sender: nil)
            }
//            switch indexPath.row{
//            case 0:
//                self.performSegueWithIdentifier("detail", sender: nil)
//            case 1:
//                self.performSegueWithIdentifier("detail", sender: nil)
//            case 2:
//                self.performSegueWithIdentifier("detail", sender: nil)
//            case 3:
//                self.performSegueWithIdentifier("healthCare", sender: nil)
//            case 4:
//                self.performSegueWithIdentifier("detail", sender: nil)
//            default:
//                break
//            }
//        case 2:
//            if indexPath.row == 0{
//                self.performSegueWithIdentifier("settings", sender: nil)
//            }
        default:
            break
        }
    }
    
    /**********************************************************************************************************/
    //MARK: - Func for change picture and tekst
    func changeUI(name: String){
        
        facultyName.text = name
        
        switch name{
            
        case "Akademija prim. umjetnosti":
            backgroundPicture.image = UIImage(named: "AkademijaPrimjenjeneUmjetnosti")
            
        case "Ekonomski fakultet":
            facultyName.text = "Ekonomski fakultet"
            backgroundPicture.image = UIImage(named: "EkonomskiFakultet")
            
        case "Fakultet za menađ. tur i ugos.":
            backgroundPicture.image = UIImage(named: "FakultetMenadzmentTurizam")
            
        case "Fakultet zdravstvenih studija":
            backgroundPicture.image = UIImage(named: "ZdravstveniStudiji")
            
        case "Filozofski fakultet":
            backgroundPicture.image = UIImage(named: "FilozofskiFakultet")
            
        case "Građevinski fakultet":
            backgroundPicture.image = UIImage(named: "GradevinskiFakultet")
            
        case "Medicinski fakultet":
            backgroundPicture.image = UIImage(named: "MedicinskiFakultet")
            
        case "Pomorski fakultet":
            backgroundPicture.image = UIImage(named: "PomorskiFakultet")
            
        case "Pravni fakultet":
            backgroundPicture.image = UIImage(named: "PravniFakultet")
            
        case "Tehnički fakultet":
            backgroundPicture.image = UIImage(named: "TehnickiFakultet")
            
        case "Učiteljski fakultet":
            backgroundPicture.image = UIImage(named: "UciteljskiFakultet")
            
        case "Odjel za biotehnologiju":
            backgroundPicture.image = UIImage(named: "OdjelBiotehnologije")
            
        case "Odjel za fiziku":
            backgroundPicture.image = UIImage(named: "OdjelFizike")
            
        case "Odjel za informatiku":
            backgroundPicture.image = UIImage(named: "OdjelInformatike")
            
        case "Odjel za matematiku":
            backgroundPicture.image = UIImage(named: "OdjelMatematike")
            
        default:
            print("Error with setting view data!")
        }

        
        
    }
    
    /**********************************************************************************************************/
    // MARK: - Navigation to selected View
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "detail"){
          
            let indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow!

            let navController: UINavigationController = segue.destinationViewController as! UINavigationController
            let instance: TmpViewController = navController.topViewController as! TmpViewController
            instance.toPass = indexPath
            
        }
    }


}
