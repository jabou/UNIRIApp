//
//  TmpViewController.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 23/05/15.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

//TODO: THIS IS TMP CLASS AND WILL BE DELETED!

import UIKit

class TmpViewController: UIViewController {
    
    var toPass: NSIndexPath!
    @IBOutlet weak var tmpLabel: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: -Functionality for menu button (open/close)
        if self.revealViewController() != nil{
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.navigationController?.navigationBar.translucent = false

        //MARK: -Enable tap and pan gesture while side menu is open
        let openMenuGesture: SWRevealViewController = self.revealViewController()
        openMenuGesture.panGestureRecognizer()
        openMenuGesture.tapGestureRecognizer()
        
        setViewTitle(toPass)
        tmpLabel.text = "This is a test View"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setViewTitle(indexPath: NSIndexPath){
        
        
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                self.title = "Stipendije"
            case 1:
                self.title = "Studentski centar"
            case 2:
                self.title = "Knjižnice"
            case 3:
                self.title = "Erasmus"
            default:
                break
            }
        case 1:
            switch indexPath.row{
            case 0:
                self.title = "Zabava"
            case 1:
                self.title = "Sport"
            case 2:
                self.title = "Kultura"
            case 3:
                self.title = "Zdravstvena zaštita"
            case 4:
                self.title = "Prijevoz"
            default:
                break
            }
        default:
            break
        }
    }
    
}
