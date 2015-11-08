//
//  WebBroswerViewController.swift
//  webBroswer
//
//  Created by Jasmin Abou Aldan on 17/07/15.
//  Copyright (c) 2015 Jasmin Abou Aldan. All rights reserved.
//

import UIKit
import WebKit

class WebBroswerViewController: UIViewController, UIWebViewDelegate, UIDocumentInteractionControllerDelegate {
    
    /**********************************************************************************************************/
    //MARK: - Variable decl
    
    var urlData: String!
    var url: NSURL!
    
    /**********************************************************************************************************/
    //MARK: - Progress bar declaration/init
    
    let progressBar = UIProgressView(progressViewStyle: UIProgressViewStyle.Bar)
    var progressBarView: UIView!
    var barAnimationDuration: NSTimeInterval = 0.27
    var fadeAnimationDuration: NSTimeInterval = 0.27
    var fadeOutDelay: NSTimeInterval = 0.1
    var progress: Float = 0.0
    let initialProgressValue: Float = 0.1
    let interactiveProgressValue: Float = 0.5
    let finalProgressValue: Float = 0.9
    var loadingCount: Int = 0
    var maxLoadCount: Int = 0
    var interactive: Bool = false
    var completeRPCURLPath: String = "webloading/complete"
    
    /**********************************************************************************************************/
    //MARK: - IBOutlets

    @IBOutlet weak var statusBar: UIView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webpageTitle: UIButton!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    /**********************************************************************************************************/
    //MARK: - Main

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegates
        self.webView.delegate = self
        
        url = NSURL(string: urlData)
        let req = NSURLRequest(URL: url!)
        self.webView.loadRequest(req)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        backButton.enabled = false
        forwardButton.enabled = false
        
        //MARK: UI Colors
        statusBar.backgroundColor = UIColor(red: 0/255, green: 53/255, blue: 119/255, alpha: 1.0)
        navigationBar.translucent = false
        toolbar.backgroundColor = UIColor(red: 0/255, green: 53/255, blue: 119/255, alpha: 1.0)

        //progressBar
        let progresBarHeight: CGFloat = 2.0
        let navigationBarBounds: CGRect = self.navigationBar.bounds
        let barFrame = CGRectMake(0, navigationBarBounds.size.height - progresBarHeight-1, navigationBarBounds.size.width, progresBarHeight)
        
        progressBarView = UIView(frame: barFrame)
        progressBarView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        progressBarView.backgroundColor = UIColor.whiteColor() 
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationBar.addSubview(progressBarView)
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        progressBarView.removeFromSuperview()

    }
    
    /**********************************************************************************************************/
    //MARK: - Progress bar funcionality
    
    func startProgress(){
        if progress < initialProgressValue {
            setProgress(initialProgressValue)
        }
    }
    
    func incrementProgress(){
        
        var tmpProgress: Float = progress
        let maxProgress: Float = interactive ? finalProgressValue : interactiveProgressValue
        let remainPercent: Float = (Float(loadingCount) / Float(maxLoadCount))
        let increment: Float = ((maxProgress - tmpProgress) * remainPercent)
        tmpProgress += increment
        tmpProgress = fmin(tmpProgress, maxProgress)
        setProgress(tmpProgress)
    }
    
    func completeProgress(){
        setProgress(1.0)
    }
    
    func reset(){
        maxLoadCount = 0
        loadingCount = 0
        interactive = false
        setProgress(0.0)
    }

    /**********************************************************************************************************/
    //MARK: - webView delegate
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if request.URL!.path == completeRPCURLPath{
            completeProgress()
            return false
        }

        let ret: Bool = true

        var isFragmentJump: Bool = false
        
        if (request.URL!.fragment) != nil {
            
            let nonFragmentURL: NSString = request.URL!.absoluteString.stringByReplacingOccurrencesOfString("#".stringByAppendingString(request.URL!.fragment!), withString: "")
            isFragmentJump = nonFragmentURL == webView.request!.URL!.absoluteString
        }
        
        let isTopLevelNavigation: Bool = request.mainDocumentURL!.isEqual(request.URL)
        
        let isHTTPOrLocalFile: Bool = request.URL?.scheme == "http" || request.URL?.scheme == "https" || request.URL?.scheme == "file"
        
        if (ret && !isFragmentJump && isHTTPOrLocalFile && isTopLevelNavigation) {
            url = request.URL
            reset()
        }
        
        return ret
    }
    
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        loadingCount++
        maxLoadCount = max(maxLoadCount,loadingCount)
        startProgress()
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        loadingCount--
        incrementProgress()
        
        let readyState: NSString = webView.stringByEvaluatingJavaScriptFromString("document.readyState")!
        
        let interactiveIn: Bool = readyState == "interactive"
        
        if interactiveIn{
            interactive = true
            
            let waitForCompleteJS: NSString = NSString(format: "window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@://%@%@'; document.body.appendChild(iframe);  }, false);", webView.request!.mainDocumentURL!.scheme, webView.request!.mainDocumentURL!.host!, completeRPCURLPath)
            webView.stringByEvaluatingJavaScriptFromString(waitForCompleteJS as String)
            
        }
        
        let isNotRedirect: Bool = (url != nil) && url.isEqual(webView.request?.mainDocumentURL)
        let complete = readyState == "complete"
        if (complete && isNotRedirect){
            completeProgress()
        }
        
        let title = webView.stringByEvaluatingJavaScriptFromString("document.title")
        webpageTitle.setTitle(title, forState: UIControlState.Normal)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        if webView.canGoBack == false && webView.canGoForward == false{
            backButton.enabled = false
            forwardButton.enabled = false
        }
        else if webView.canGoBack == true && webView.canGoForward == false{
            backButton.enabled = true
            forwardButton.enabled = false
        }
        else if webView.canGoForward == true && webView.canGoBack == false{
            forwardButton.enabled = true
            backButton.enabled = false
        }
        else{
            forwardButton.enabled = true
            backButton.enabled = true
        }

    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        loadingCount--
        incrementProgress()
        
        let readyState: NSString = webView.stringByEvaluatingJavaScriptFromString("document.readyState")!

        let interactiveIn: Bool = readyState == "interactive"
        if interactiveIn{
            interactive = true
            
            let waitForCompleteJS: NSString = NSString(format: "window.addEventListener('load',function() { var iframe = document.createElement('iframe'); iframe.style.display = 'none'; iframe.src = '%@://%@%@'; document.body.appendChild(iframe);  }, false);", webView.request!.mainDocumentURL!.scheme, webView.request!.mainDocumentURL!.host!, completeRPCURLPath)
            webView.stringByEvaluatingJavaScriptFromString(waitForCompleteJS as String)
            
        }
        
        let isNotRedirect: Bool = (url != nil) && url.isEqual(webView.request?.mainDocumentURL)
        let complete = readyState == "complete"
        if (complete && isNotRedirect) || (error == true){

                completeProgress()
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    /**********************************************************************************************************/
    //MARK: - Progress bar view
    
    func setProgress(setProgressValue: Float, animated: Bool = true){
        
        if setProgressValue > progress || setProgressValue == 0 {
            progress = setProgressValue
            
        }
        
        let isGrowing: Bool = setProgressValue > 0.0
        
        UIView.animateWithDuration((isGrowing && animated) ? barAnimationDuration : 0.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            var frame: CGRect = self.progressBarView.frame
            frame.size.width = CGFloat(setProgressValue) * self.navigationBar.bounds.size.width
            self.progressBarView.frame = frame
            }, completion: nil)
        
        if setProgressValue >= 1.0 {
            UIView.animateWithDuration(animated ? fadeAnimationDuration : 0.0, delay: fadeOutDelay, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.progressBarView.alpha = 0.0
                }, completion: { (completed) -> Void in
                    var frame: CGRect = self.progressBarView.frame
                    frame.size.width = 0
                    self.progressBarView.frame = frame
            })
            
        } else {
            
            UIView.animateWithDuration(animated ? fadeAnimationDuration : 0.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.progressBarView.alpha = 1.0
                }, completion: nil)
        }
    }
    
    /**********************************************************************************************************/
    //MARK: - IBActions

    @IBAction func dismissButton(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func copyLink(sender: AnyObject) {
        UIPasteboard.generalPasteboard().string = urlData
        
        let backgroundView = UIView()
        let textLabel = UILabel()
        let picture = UIImageView()
        //let activityIndicator = UIActivityIndicatorView()
        
        
        backgroundView.frame = CGRectMake(0, 0, 130, 130)
        backgroundView.center = view.center
        backgroundView.backgroundColor = UIColor(red: 39/255, green: 38/255, blue: 39/255, alpha: 0.9)
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 10
        backgroundView.alpha = 1
        
        textLabel.frame = CGRectMake(0, 0, 130, 80)
        textLabel.backgroundColor = UIColor.clearColor()
        textLabel.textColor = UIColor.whiteColor()
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.textAlignment = NSTextAlignment.Center
        textLabel.center = CGPointMake(backgroundView.bounds.width/2, backgroundView.bounds.height/2 + 30)
        textLabel.text = "Link je kopiran!"
        
        picture.frame = CGRectMake(0, 0, 50, 50)
        picture.center = CGPointMake(backgroundView.bounds.width/2, backgroundView.bounds.height/2 - 15)
        picture.image = UIImage(named: "copy-link")

        backgroundView.addSubview(picture)
        backgroundView.addSubview(textLabel)
        view.addSubview(backgroundView)
    
        UIView.animateWithDuration(1.0, delay: 0.6, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            backgroundView.alpha = 0.0
        }) { (finished) -> Void in
            backgroundView.removeFromSuperview()
        }
    }
    
    @IBAction func openInActionButton(sender: AnyObject) {
        
        let textToShare: NSString = "This website is shared from UNIRI App.";
        
        let objectsToShare: [AnyObject]? = [textToShare, url];
        let safariActivity = SafaryActivity()
        
        let activityVC: UIActivityViewController = UIActivityViewController(activityItems: objectsToShare!, applicationActivities: [safariActivity])
        
        self.presentViewController(activityVC, animated: true, completion: nil)
        
    }
}
