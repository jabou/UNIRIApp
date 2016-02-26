//
//  StudentCenterTabViewController.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 26/11/2015.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit

class StudentCenterTabViewController: UITabBarController {

    /**********************************************************************************************************/
    //MARK: - Main
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //MARK: TAB names
        let tabItems: [UITabBarItem] = self.tabBar.items!
        let tabItem0 = tabItems[0] as UITabBarItem
        let tabItem1 = tabItems[1] as UITabBarItem
        let tabItem2 = tabItems[2] as UITabBarItem
        tabItem0.title = "Prehrana"
        tabItem1.title = "Smještaj"
        tabItem2.title = "Informacije"
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
