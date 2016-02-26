//
//  MainViewController.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 14/11/2015.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit
import CoreData


class MainViewController: UIViewController {
    
    /**********************************************************************************************************/
    //MARK: - IBOutlet
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var facultyName: UILabel!
    @IBOutlet weak var facultyImage: UIImageView!
    @IBOutlet weak var facultyAdress: UILabel!
    @IBOutlet weak var facultyTelephoneNumber: UILabel!
    @IBOutlet weak var facultyEmail: UILabel!
    @IBOutlet weak var facultyHeadPerson: UILabel!
    @IBOutlet weak var facultyWorkHours: UILabel!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    /**********************************************************************************************************/
    //MARK: - Main
    
    override func viewWillAppear(animated: Bool) {
        //MARK: connect to database
        let fetchRequest = NSFetchRequest(entityName: "UserData")
        
        do{
            let fetch = try managedObjectContext?.executeFetchRequest(fetchRequest)
            
            if fetch!.isEmpty == false{
                do {
                    if let choosenFaculty = try managedObjectContext!.executeFetchRequest(fetchRequest) as? [Model]{
                        
                        dataForChoosenFaculty(choosenFaculty[0].chosenFaculty)
                        
                    }
                } catch {
                    print("Data was not retrieved!")
                }
            }
            
        } catch {
            print("Error fetching data for save")
        }

    }

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
     //MARK: - Data Fill
    func dataForChoosenFaculty(faculty: String){
        
        switch faculty{
        
        case "Akademija prim. umjetnosti":
            facultyName.text = "Akademija primjenjenih umjetnosti"
            facultyImage.image = UIImage(named: "AkademijaPrimjenjeneUmjetnosti")
            facultyAdress.text = "Slavka Krautzeka 83"
            facultyTelephoneNumber.text = "051/228-880"
            facultyEmail.text = "dekanat@apuri.hr"
            facultyHeadPerson.text = "red.prof.art.Josip Butković"
            facultyWorkHours.text = "09:00 - 21:00"
            
        case "Ekonomski fakultet":
            facultyName.text = "Ekonomski fakultet"
            facultyImage.image = UIImage(named: "EkonomskiFakultet")
            facultyAdress.text = "Ivana Filipovića 4"
            facultyTelephoneNumber.text = "051/355-111"
            facultyEmail.text = "efri@efri.hr"
            facultyHeadPerson.text = "prof.dr.sc Heri Bezić"
            facultyWorkHours.text = "09:00 - 21:00"
            
        case "Fakultet za menađ. tur i ugos.":
            facultyName.text = "Fakultet za menadž. turizam i ugost."
            facultyImage.image = UIImage(named: "FakultetMenadzmentTurizam")
            facultyAdress.text = "Primorska 42, Opatija"
            facultyTelephoneNumber.text = "051/294-700"
            facultyEmail.text = "doras@fthm.hr"
            facultyHeadPerson.text = "prof. dr. sc. Dora Smolčić Jurdana"
            facultyWorkHours.text = "00:09 - 21:00"
            
        case "Fakultet zdravstvenih studija":
            facultyName.text = "Fakultet zdravstvenih studija"
            facultyImage.image = UIImage(named: "ZdravstveniStudiji")
            facultyAdress.text = "Viktora  Cara Emina 5"
            facultyTelephoneNumber.text = "051/688-266"
            facultyEmail.text = "dekanatfzsri@uniri.hr"
            facultyHeadPerson.text = "prof.dr.sc Alan Šustić"
            facultyWorkHours.text = "00:09 - 21:00"
            
        case "Filozofski fakultet":
            facultyName.text = "Filozofski fakultet"
            facultyImage.image = UIImage(named: "FilozofskiFakultet")
            facultyAdress.text = "Sveučilišna avenija 4"
            facultyTelephoneNumber.text = "051/265-600"
            facultyEmail.text = "dekanat@ffri.hr"
            facultyHeadPerson.text = "izv.prof.dr.sc. Ines Srdoč-Konestra"
            facultyWorkHours.text = "00:09 - 21:00"
            
        case "Građevinski fakultet":
            facultyName.text = "Građevinski fakultet"
            facultyImage.image = UIImage(named: "GradevinskiFakultet")
            facultyAdress.text = "Radmile Matejčić 3"
            facultyTelephoneNumber.text = "051/265-900"
            facultyEmail.text = "info@gradri.uniri.hr"
            facultyHeadPerson.text = "izv.prof.dr.sc. Ivana Štimac Grandić"
            facultyWorkHours.text = "00:09 - 21:00"
            
        case "Medicinski fakultet":
            facultyName.text = "Medicinski fakultet"
            facultyImage.image = UIImage(named: "MedicinskiFakultet")
            facultyAdress.text = "Braće Branchetta 20/1"
            facultyTelephoneNumber.text = "051/651-111"
            facultyEmail.text = "dekanat@medri.hr"
            facultyHeadPerson.text = "prof.dr.sc. Tomislav Rukavina"
            facultyWorkHours.text = "00:09 - 21:00"
            
        case "Pomorski fakultet":
            facultyName.text = "Pomorski fakultet"
            facultyImage.image = UIImage(named: "PomorskiFakultet")
            facultyAdress.text = "Studentska ulica 2"
            facultyTelephoneNumber.text = "051/338-411"
            facultyEmail.text = "dekanat@pfri.hr"
            facultyHeadPerson.text = "prof.dr.sc.Serđo Kos"
            facultyWorkHours.text = "00:09 - 21:00"
            
        case "Pravni fakultet":
            facultyName.text = "Pravni fakultet"
            facultyImage.image = UIImage(named: "PravniFakultet")
            facultyAdress.text = "Hahlić 6"
            facultyTelephoneNumber.text = "051/359-500"
            facultyEmail.text = "dekanat@pravri.hr"
            facultyHeadPerson.text = "prof.dr.sc.Eduard Kunštek"
            facultyWorkHours.text = "00:09 - 21:00"
            
        case "Tehnički fakultet":
            facultyName.text = "Tehnički fakultet"
            facultyImage.image = UIImage(named: "TehnickiFakultet")
            facultyAdress.text = "Vukovarska 58"
            facultyTelephoneNumber.text = "051/651-444"
            facultyEmail.text = "dekanat@riteh.hr"
            facultyHeadPerson.text = "prof.dr.sc Goran Turkalj"
            facultyWorkHours.text = "00:09 - 21:00"
            
        case "Učiteljski fakultet":
            facultyName.text = "Učiteljski fakultet"
            facultyImage.image = UIImage(named: "UciteljskiFakultet")
            facultyAdress.text = "Sveučilišna avenija 6"
            facultyTelephoneNumber.text = "051/265-800"
            facultyEmail.text = "dekanat@ufri.hr"
            facultyHeadPerson.text = "prof.dr.sc Jasna Krstović"
            facultyWorkHours.text = "00:09 - 21:00"
            
        case "Odjel za biotehnologiju":
            facultyName.text = "Odjel za biotehnologiju"
            facultyImage.image = UIImage(named: "OdjelBiotehnologije")
            facultyAdress.text = "Radmile Matejčić 2"
            facultyTelephoneNumber.text = "051/584-550"
            facultyEmail.text = "ured@biotech.uniri.hr"
            facultyHeadPerson.text = "dr.sc.Anđelka Radojčić Badovinac"
            facultyWorkHours.text = "00:09 - 21:00"
            
        case "Odjel za fiziku":
            facultyName.text = "Odjel za fiziku"
            facultyImage.image = UIImage(named: "OdjelFizike")
            facultyAdress.text = "Radmile Matejčić 2"
            facultyTelephoneNumber.text = "051/584-600"
            facultyEmail.text = "fizika@phy.uniri.hr"
            facultyHeadPerson.text = "izv.prof.dr.sc. Rajka Jurdana-Šepić"
            facultyWorkHours.text = "00:09 - 21:00"
            
        case "Odjel za informatiku":
            facultyName.text = "Odjel za informatiku"
            facultyImage.image = UIImage(named: "OdjelInformatike")
            facultyAdress.text = "Radmile Matejčić 2"
            facultyTelephoneNumber.text = "051/584-700"
            facultyEmail.text = "ured@inf.uniri.hr"
            facultyHeadPerson.text = "izv. prof. dr. sc. Patrizia Poščić"
            facultyWorkHours.text = "00:09 - 21:00"
            
        case "Odjel za matematiku":
            facultyName.text = "Odjel za matematiku"
            facultyImage.image = UIImage(named: "OdjelMatematike")
            facultyAdress.text = "Radmile Matejčić 2"
            facultyTelephoneNumber.text = "0051/584-650"
            facultyEmail.text = "math@math.uniri.hr"
            facultyHeadPerson.text = "izv.prof.dr.sc. Sanja Rukavina"
            facultyWorkHours.text = "00:09 - 21:00"
            
        default:
            print("Error with setting view data!")
        }
    }
    
    /**********************************************************************************************************/
    //MARK: - Button actions
    
    @IBAction func navigationStart(sender: AnyObject) {
        
        let address = self.facultyAdress.text?.stringByReplacingOccurrencesOfString(" ", withString: "+") as String!
        let filteredAddress = address.stringByFoldingWithOptions(NSStringCompareOptions.DiacriticInsensitiveSearch, locale: NSLocale.currentLocale())
        
        let url: String!
        if (facultyName.text == "Fakultet za menadž. turizam i ugost.") {
            url = "http://maps.apple.com/?address=\(filteredAddress),Croatia"
        } else {
            url = "http://maps.apple.com/?address=\(filteredAddress),Rijeka,Croatia"
        }
        print(url)
        
        let navigationAlert: UIAlertController = UIAlertController(title: "Pokretanje navigacije", message: "Želiš li pokrenuti navigaciju do:\n \(facultyAdress.text!)", preferredStyle: UIAlertControllerStyle.Alert)
        navigationAlert.addAction(UIAlertAction(title: "Da", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }))
        navigationAlert.addAction(UIAlertAction(title: "Ne", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(navigationAlert, animated: true, completion: nil)
    }

    @IBAction func phoneCall(sender: AnyObject) {
        
        let number = facultyTelephoneNumber.text!
        
        let navigationAlert: UIAlertController = UIAlertController(title: "Uspostava poziva", message: "Želiš li nazvati broj: \n \(number)", preferredStyle: UIAlertControllerStyle.Alert)
        navigationAlert.addAction(UIAlertAction(title: "Da", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://\(number)")!)
        }))
        navigationAlert.addAction(UIAlertAction(title: "Ne", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(navigationAlert, animated: true, completion: nil)

    }
    
    @IBAction func mailSend(sender: AnyObject) {
        
        let mail = facultyEmail.text!
        
        let navigationAlert: UIAlertController = UIAlertController(title: "Slanje e-mail poruke", message: "Želiš li poslati e-mail na:\n \(mail)", preferredStyle: UIAlertControllerStyle.Alert)
        navigationAlert.addAction(UIAlertAction(title: "Da", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            UIApplication.sharedApplication().openURL(NSURL(string: "mailto:\(mail)")!)
        }))
        navigationAlert.addAction(UIAlertAction(title: "Ne", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(navigationAlert, animated: true, completion: nil)
    }
}
