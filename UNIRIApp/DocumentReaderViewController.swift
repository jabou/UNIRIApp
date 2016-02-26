//
//  ScholarshipGuideViewController.swift
//  UNIRIApp
//
//  Created by Jasmin Abou Aldan on 08/11/2015.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit

class DocumentReaderViewController: UIViewController, UIDocumentInteractionControllerDelegate {

    /**********************************************************************************************************/
    //MARK: - IBOutlets
    
    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var dataView: UIWebView!
    @IBOutlet weak var customNavigationBar: UINavigationBar!
    @IBOutlet weak var viewTitle: UINavigationItem!
    
    /**********************************************************************************************************/
    //MARK: - Variable init/decl
    
    var documentName: String!
    var sendTitle: String!
    
    /**********************************************************************************************************/
    //MARK: - Main
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //MARK: UI Colors
        statusBarView.backgroundColor = UIColor(red: 0/255, green: 53/255, blue: 119/255, alpha: 1.0)
        customNavigationBar.translucent = false
        self.view.backgroundColor = UIColor.blackColor()
        viewTitle.title = sendTitle
        
        //MARK: Load and show pdf
        let path: String = NSBundle.mainBundle().pathForResource(documentName, ofType: "pdf")!
        let targetURL: NSURL = NSURL.fileURLWithPath(path)
        let pdfData: NSData = NSData(contentsOfURL: targetURL)!
        dataView.loadData(pdfData, MIMEType: "application/pdf", textEncodingName: "utf-8", baseURL: NSURL())
        dataView.scalesPageToFit = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /**********************************************************************************************************/
    //MARK: - Dismiss View
    
    @IBAction func dismissButton(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }

    /**********************************************************************************************************/
    //MARK: - Opening data in other Applications
    
    @IBAction func openInActionButton(sender: AnyObject) {
        
        let path: String = NSBundle.mainBundle().pathForResource(documentName, ofType: "pdf")!
        let targetURL: NSURL = NSURL.fileURLWithPath(path)
        
        var documentsController: UIDocumentInteractionController!
        documentsController = UIDocumentInteractionController(URL: targetURL)
        documentsController.delegate = self
        documentsController.UTI = "com.adobe.pdf"
        documentsController.presentOpenInMenuFromRect(CGRectZero, inView: self.view, animated: true)
    }
    
    func documentInteractionController(controller: UIDocumentInteractionController, willBeginSendingToApplication application: String?) {
        print("Will begin send", terminator: "")
    }
    
    func documentInteractionController(controller: UIDocumentInteractionController, didEndSendingToApplication application: String?) {
        print("Did end sending", terminator: "")
    }
}
