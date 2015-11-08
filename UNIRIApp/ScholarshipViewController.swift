//
//  ScholarshipViewController.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 09/07/15.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit

class ScholarshipViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    /**********************************************************************************************************/
    //MARK: - Variable init nad decl
    
    var searchActive: Bool = false
    let scolarshipType = ["Državne stipendije","Sveučilišne stipendije"]
    let cities: NSArray = ["Bakar","Cres","Crikvenica","Čabar","Delnice","Kastav","Kraljevica","Krk","Mali Lošinj","Novi Vinodolski","Novi Vinodolski","Opatija","Rab","Rijeka","Rijeka","Rijeka","Vrbovsko"]
    let citiesSubtitle: NSArray = [" "," "," ","Socijalni kriteriji"," "," "," "," "," ","Daroviti studenti","Socijalni kriteriji"," "," ","Daroviti studenti","Deficitarna zanimanja","Socijalni kriteriji"," "]
    let community: NSArray = ["Brod Moravice","Čavle", "Dobrinj","Fužine","Jelenje","Kostrena","Lopar","Lovran","Malinska","Matulji","Mrkopalj","Omišalj","Punat","Ravna Gora","Skrad","Vinodolski","Viškovo","Vrbnik"]
    let communitySubtitle: NSArray = [" "," "," "," "," "," "," "," "," "," ","Sportske stipendije"," "," ","Socijalni kriteriji","Socijalni kriteriji"," "," "," "]
    var filteredCities: NSMutableArray = []
    var filteredCitiesSubtitle: NSMutableArray = []
    var filteredCommunity: NSMutableArray = []
    var filteredCommunitySubtitle: NSMutableArray = []
    
    /**********************************************************************************************************/
    //MARK: - IBOutlet
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var mainListTableView: UITableView!
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    /**********************************************************************************************************/
    //MARK: - Main

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: TableView delegate
        //mainListTableView.delegate = self
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        mainListTableView.delegate = self
        mainListTableView.dataSource = self
        searchBar.delegate = self
        
        //MARK: Change colors and title, add right info button
        self.view.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
        self.title = "Stipendije"
        let infoButton: AnyObject = UIButton(type: UIButtonType.InfoLight)
        infoButton.addTarget(self, action: "guide", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoButton as! UIView)
        self.navigationController?.navigationBar.translucent = false
        searchBar.barTintColor = UIColor.whiteColor()
        
        
        //MARK: Functionality for menu button (open/close)
        if self.revealViewController() != nil{
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
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
    //MARK: - Func for open guide view
    
    func guide(){
        self.performSegueWithIdentifier("schoolarskipGuide", sender: self)
    }
    
    /**********************************************************************************************************/
    //MARK: - Search bar delegate
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchActive = false
        filteredCities.removeAllObjects()
        searchBar.resignFirstResponder()
        searchBar.text = ""
        citiesTableView.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBar.resignFirstResponder()
        enableCancleButton(searchBar)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
        enableCancleButton(searchBar)
    }

    //For Cancel button to be enabled!
    func enableCancleButton (searchBar : UISearchBar) {
        for view1 in searchBar.subviews {
            for view2 in view1.subviews {
                if view2.isKindOfClass(UIButton) {
                    let button = view2 as! UIButton
                    button.enabled = true
                    button.userInteractionEnabled = true
                }
            }
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchBar.showsCancelButton = true
        
        if searchBar.text!.isEmpty{
            searchActive = false
            citiesTableView.reloadData()
        } else {

            searchActive = true
            filteredCities.removeAllObjects()
            filteredCitiesSubtitle.removeAllObjects()
            filteredCommunity.removeAllObjects()
            filteredCommunitySubtitle.removeAllObjects()
            
            for (var index = 0; index < cities.count; index++) {

                let currentCity = cities.objectAtIndex(index) as! String
                let currentCitySubtitle = citiesSubtitle.objectAtIndex(index) as! String
                if currentCity.lowercaseString.rangeOfString(searchText.lowercaseString, options: NSStringCompareOptions.DiacriticInsensitiveSearch) != nil{
                    filteredCities.addObject(currentCity)
                    filteredCitiesSubtitle.addObject(currentCitySubtitle)
                }
            }
            
            for (var index = 0; index < community.count; index++) {
                
                let currentCommunity = community.objectAtIndex(index) as! String
                let currentCommunitySubtitle = communitySubtitle.objectAtIndex(index) as! String
                if currentCommunity.lowercaseString.rangeOfString(searchText.lowercaseString, options: NSStringCompareOptions.DiacriticInsensitiveSearch)  != nil {
                    filteredCommunity.addObject(currentCommunity)
                    filteredCommunitySubtitle.addObject(currentCommunitySubtitle)
                }
            }
            
            citiesTableView.reloadData()
        }
    }

    /**********************************************************************************************************/
    //MARK: - Table view setup
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == self.citiesTableView{
            return 2
        }
        else {
            return 1
        }
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.citiesTableView{
            return 25
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRectMake(20, 0, tableView.bounds.size.width-5, 15))
        label.font = UIFont(name: "Helvetica Neue", size: 12)
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor(red: 4/255, green: 79/255, blue: 132/255, alpha: 1.0)
        
        if tableView == self.citiesTableView{
            if section == 0 {
                label.text = " Gradske"
                return label
            }
            else{
                label.text = " Općinske"
                return label
            }
        }
        
        return nil
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.citiesTableView{
       
            if section == 0{
                if (searchActive == true) {
                    return filteredCities.count
                }
                else{
                    return cities.count
                }
            }
            
            else{
                if (searchActive == true) {
                    return filteredCommunity.count
                }
                else{
                    return community.count
                }
            }
        }
        else{
            return scolarshipType.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == self.citiesTableView{
            let cell = tableView.dequeueReusableCellWithIdentifier("CitiesCell")
            cell!.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
            
            if indexPath.section == 0{
                if searchActive == true{
                    cell!.textLabel?.text = filteredCities[indexPath.row] as? String
                    cell!.detailTextLabel?.text = filteredCitiesSubtitle[indexPath.row] as? String
                }
                else{
                    cell!.textLabel?.text = cities[indexPath.row] as? String
                    cell!.detailTextLabel?.text = citiesSubtitle[indexPath.row] as? String
                }
            }
            else{
                if searchActive == true{
                    cell!.textLabel?.text = filteredCommunity[indexPath.row] as? String
                    cell!.detailTextLabel?.text = filteredCommunitySubtitle[indexPath.row] as? String
                } else {
                    cell!.textLabel?.text = community[indexPath.row] as? String
                    cell!.detailTextLabel?.text = communitySubtitle[indexPath.row] as? String
                }
            }
            return cell!
        }
            
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("scholarshipCell")
            cell!.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0)
            cell!.textLabel?.text = scolarshipType[indexPath.row]
            
            if indexPath.row == 2{
                cell!.selectionStyle = UITableViewCellSelectionStyle.None
            }
            
            return cell!
        }
    }

    //deselect selected row
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        searchBar.resignFirstResponder()
        
        if tableView == self.citiesTableView{
            
            let cell: UITableViewCell = citiesTableView.cellForRowAtIndexPath(indexPath)!
            let title: String = cell.textLabel!.text!
            //var subtitle: String = cell.detailTextLabel!.text!
            
            if cities.containsObject(title) || community.containsObject(title) {
                performSegueWithIdentifier("webBroswerSchoolarship", sender: self)
                self.citiesTableView.deselectRowAtIndexPath(citiesTableView.indexPathForSelectedRow!, animated: true)
            }
            
        } else {
            
            switch indexPath.row{
            case 0,1:
                performSegueWithIdentifier("webBroswerSchoolarship", sender: self)
                self.mainListTableView.deselectRowAtIndexPath(mainListTableView.indexPathForSelectedRow!, animated: true)
            default:
                break
            }
        }
    }
    
    /**********************************************************************************************************/
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "schoolarskipGuide" {
            let instance: DocumentReaderViewController = segue.destinationViewController as! DocumentReaderViewController
            instance.documentName = "guide"
            instance.sendTitle = "Vodič"
        }

        if let indexPath = self.citiesTableView.indexPathForSelectedRow{

            let cell: UITableViewCell = citiesTableView.cellForRowAtIndexPath(indexPath)!
            let title: String = cell.textLabel!.text!
            let subtitle: String = cell.detailTextLabel!.text!
            var dataForSend: String

            
            switch title{
            case "Bakar":
                dataForSend = "http://www.bakar.hr/index.php?option=com_k2&view=item&id=331:natjecaj-za-dodjelu-stipendija-za-skolsku-akademsku-2014-2015&Itemid=880"
            case "Cres":
                dataForSend = "http://www.cres.hr/natjecaj-za-dodjelu-stipendija/1279"
            case "Crikvenica":
                dataForSend = "http://www.crikvenica.hr/natjecaji/stipendije.html"
            case "Čabar":
                dataForSend = "http://www.cabar.hr/2014/10/23/natjeeaj-za-dodjrlu-socijalnih-stipendija/"
            case "Delnice":
                dataForSend = "http://www.delnice.hr/3a%20tekst%20natjecaja.pdf"
            case "Kastav":
                dataForSend = "http://www.kastav.hr/clanak/2014/08/25/natje-aj-za-dodjelu-stipendija-u-enicima-i-studentima-za-kolsku-akademsku-20142015"
            case "Kraljevica":
                dataForSend = "http://www.kraljevica.hr/Clanak.aspx?cid=555"
            case "Krk":
                dataForSend = "http://www.grad-krk.hr/banneriDesnoGore/Natjecaji/Natjecaj-za-dodjelu-stipendija-ucenicima-i-student.aspx"
            case "Mali Lošinj":
                dataForSend = "http://www.mali-losinj.hr/07/10/2014/natjecaj-za-dodjelu-studentskih-stipendija-za-akademsku-godinu-20142015/"
            case "Novi Vinodolski":
            if subtitle == "Daroviti studenti"{
                dataForSend = "http://www.stipendije.info/hr/natjecaji/4500/stipendije_grada_novi_vinodolski_za_darovite_ucenike_i_studente"
            }
            else{
                dataForSend = "http://www.stipendije.info/hr/natjecaji/4499/stipendije_grada_novi_vinodolski_za_socijalno_ugrozene_ucenike_i_studente"
            }
            case "Opatija":
                dataForSend = "http://www.opatija.hr/files/file/novosti/2014/listopad/Natjecaj-za-2014-2015.pdf"
            case "Rab":
                dataForSend = "http://www.rab.hr/grad-rab/natjechaj/natjechaj-za-dodjelu-uchenichkih-i-studentskih-stipendija-za-2014-2015"
            case "Rijeka":
            if subtitle == "Daroviti studenti"{
                dataForSend = "http://www.rijeka.hr/DodjelaStipendijaDarovitima"
            }
            else if subtitle == "Deficitarna zanimanja"{
                dataForSend = "http://www.rijeka.hr/StipendiranjeDeficitaraca"
            }
            else{
                dataForSend = "http://www.rijeka.hr/StipendiranjeSocijalniKriterij"
            }
            case "Vrbovsko":
                dataForSend = "http://gorskenovosti.net/2014/11/09/u-vrbovskom-raspisan-natjecaj-za-dodjelu-stipendija-ucenicima-i-studentima-po-prvi-puta-osigurano-financiranje-i-uspjesnih-sportasa/"
            case "Brod Moravice":
                dataForSend = "http://www.brodmoravice.hr/files/natjecaj_za_stipendiranje_14.doc"
            case "Čavle":
                dataForSend = "http://www.cavle.hr/javni-natjecaj-za-dodjelu-srednjoskolskih-i-studentskih-stipendija-u-godini-2014-2015/"
            case "Dobrinj":
                dataForSend = "http://www.dobrinj.hr/documents/natjecaj-za-dodjelu-stipendija-opcine-dobrinj-02112014.pdf"
            case "Fužine":
                dataForSend = "http://www.stipendije.info/hr/natjecaji/stipendije_opcine_fuzine"
            case "Jelenje":
                dataForSend = "http://jelenje.hr/?p=15"
            case "Kostrena":
                dataForSend = "http://www.kostrena.hr/pd/2673/Javni-natjecaj-za-dodjelu-stipendija-ucenicima-i-studentima-za-skolsku---akademsku-godinu-2014--2015.wshtml"
            case "Lopar":
                dataForSend = "http://www.opcina-lopar.hr/javni-poziv-za-dodjelu-stipendija-u-skolskojakademskoj-2014-2015-godini/"
            case "Lovran":
                dataForSend = "http://www.stipendije.info/hr/natjecaji/stipendije_opcine_lovran"
            case "Malinska":
                dataForSend = "http://www.malinska.hr/vijesti_pregled_2014.html?countrytabs=25"
            case "Matulji":
                dataForSend = "http://www.matulji.hr/component/content/article/392-natjeaj-za-stipendiranje-studenata-"
            case "Mrkopalj":
                dataForSend = "http://www.mrkopalj.hr/dokumenti/odluka%20sportske%20stipendije%203.pdf"
            case "Omišalj":
                dataForSend = "http://www.omisalj.hr/hr/495/n-a-t-j-e-c-a-j-za-dodjelu-stipendija-studentima-poslijediplomskih-studija-za-akademsku-2015-2016-godinu"
            case "Punat":
                dataForSend = "http://www.opcina.punat.hr/node/229"
            case "Ravna Gora":
                dataForSend = "http://www.ravnagora.hr/Repository/Dokumenti/natjecaj%20za%20socijalne%20stipendije%202014.pdf"
            case "Skrad":
                dataForSend = "http://www.skrad.hr/dokumenti/natjecaj-soc-stipendije2013-plakat.pdf"
            case "Vinodolski":
                dataForSend = "http://www.stipendije.info/hr/natjecaji/stipendije_vinodolske_opcine"
            case "Viškovo":
                dataForSend = "http://www.opcina-viskovo.hr/www.opcina-viskovo.hr/files/95/950b4b1f-3a48-4d05-99d4-c43cad24fb21.pdf"
            case"Vrbnik":
                dataForSend = "http://www.opcina-vrbnik.hr/natjecaj-za-dodojelu-stipendija-studentima/"
            default:
                dataForSend = ""
            }
            
            let instance: WebBroswerViewController = segue.destinationViewController as! WebBroswerViewController
            instance.urlData = dataForSend
            
        }
        else{
            if (segue.identifier == "webBroswerSchoolarship"){
                
                let indexPath: NSIndexPath = self.mainListTableView.indexPathForSelectedRow!
                var dataForSend: String
                
                switch indexPath.row{
                case 0:
                    dataForSend = "http://public.mzos.hr/Default.aspx?sec=2263"
                case 1:
                    dataForSend = "http://www.uniri.hr/index.php?option=com_content&view=category&layout=blog&id=221&Itemid=258&lang=hr"
                default:
                    dataForSend = ""
                }
                
                let instance: WebBroswerViewController = segue.destinationViewController as! WebBroswerViewController
                instance.urlData = dataForSend
                
            }
        }
    }

    
}
