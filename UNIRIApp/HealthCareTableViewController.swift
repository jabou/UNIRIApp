//
//  HealthCareTableViewController.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 26/06/15.
//  Copyright © 2015 Jasmin Abou Aldan, Monika Švogor. All rights reserved.
//

import UIKit

class HealthCareTableViewController: UITableViewController {
    
    /**********************************************************************************************************/
    //MARK: - Variable init/decl
    
    var toPass: NSIndexPath!
    let generalMedicine = ["Badurina Miljana","Bradičić-Vivoda Zrinka","Ivošević Dejan","Ljubotina Aleksandar","Bardićev-Novaković Zdenka","Diminić-Lisica Ines","Popović Branislava","Uroda-Rušinić Alemka"]
    let generalMedicineSub = ["Ambulanta \"Piramida-Sušak\"","Ambulanta \"Podmurvice\"","Ambulanta \"Šurinje\"","Ambulanta \"Luka\"","Ambulanta \"Centar\"","Ambulanta \"Vežica\"","Ambulanta \"Centar-Školska\"","Ambulanta \"Vežica\""]
    let dentalMedicine = ["Gržić Renata"]
    let dentalMedicineSub = ["Klinika za dentalnu medicinu, KBC Rijeka"]
    let ginoMedicine = ["Krištofić Ines","Ćosić-Vušković Karolina"]
    let ginoMedicineSub = ["Ginekološka ambulanta","Ginekološka ambulanta"]
    let psychMedicine = ["Studentski savjetovališni centar","Dadić-Hero Elizabeta"]
    let psychMedicineSub = ["Sveučilišni kampus na Trsatu","Psihijatrijska ordinacija"]
    
    /**********************************************************************************************************/
    //MARK: - IBOutlet
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    /**********************************************************************************************************/
    //MARK: - Main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Functionality for menu button (open/close)
        if self.revealViewController() != nil{
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.navigationController?.navigationBar.translucent = false
        
        //MARK: Enable tap and pan gesture while side menu is open
        let openMenuGesture: SWRevealViewController = self.revealViewController()
        openMenuGesture.panGestureRecognizer()
        openMenuGesture.tapGestureRecognizer()
        
        self.title = "Zdravstvena zaštita"
        
        //MARK: Rename "Back" to "Nazad"
        let backButton = UIBarButtonItem(title: "Nazad", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**********************************************************************************************************/
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return generalMedicine.count
        case 1:
            return dentalMedicine.count
        case 2:
            return ginoMedicine.count
        case 3:
            return psychMedicine.count
        default:
            return 0
            
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: (NSIndexPath!)) {
        self.tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: true)
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRectMake(20, 0, tableView.bounds.size.width-5, 15))
        label.font = UIFont(name: "Helvetica Neue", size: 12)
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor(red: 4/255, green: 79/255, blue: 132/255, alpha: 1.0)
        
        switch section{
        case 0:
            label.text = "  OPĆA/OBITELJSKA MEDICINA"
            return label
        case 1:
            label.text = "  DENTALNA MEDICINA"
            return label
        case 2:
            label.text = "  GINEKOLOGIJA"
            return label
        case 3:
            label.text = "  PSIHOLOŠKA POMOĆ I PSIHIJATRIJA"
            return label
        default:
            return nil
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("healthCareCell", forIndexPath: indexPath)
        
        cell?.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        
        
        switch indexPath.section{
        case 0:
            cell!.textLabel?.text = generalMedicine[indexPath.row]
            cell!.detailTextLabel?.text = generalMedicineSub[indexPath.row]
        case 1:
            cell!.textLabel?.text = dentalMedicine[indexPath.row]
            cell!.detailTextLabel?.text = dentalMedicineSub[indexPath.row]
        case 2:
            cell!.textLabel?.text = ginoMedicine[indexPath.row]
            cell!.detailTextLabel?.text = ginoMedicineSub[indexPath.row]
        case 3:
            cell!.textLabel?.text = psychMedicine[indexPath.row]
            cell!.detailTextLabel?.text = psychMedicineSub[indexPath.row]
        default:
            break
        }
        
        
        return cell!
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
