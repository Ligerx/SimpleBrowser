//
//  ViewController.swift
//  SimpleBrowser
//
//  Created by Alex Wang on 9/15/16.
//  Copyright © 2016 Alex Wang. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, UITextFieldDelegate {

    @IBOutlet weak var locationField: UITextField!
    var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "https://apple.com")
        webView.loadRequest(NSURLRequest(URL: url!))
        webView.allowsBackForwardNavigationGestures = true
        locationField.text = "apple.com"
        locationField.selectedTextRange = locationField.textRangeFromPosition(locationField.beginningOfDocument, toPosition: locationField.endOfDocument)
        locationField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openPage(sender: AnyObject) {
        goToPage()
    }

    @IBAction func backTapped(sender: AnyObject) {
        webView.goBack()
    }
    
    @IBAction func forwardTapped(sender: AnyObject) {
        webView.goForward()
    }
    
    @IBAction func stopTapped(sender: AnyObject) {
        webView.stopLoading()
    }
    
    @IBAction func refreshTapped(sender: AnyObject) {
        webView.reload()
    }
    
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .Alert)
        
        locationField.text = ""
        locationField.becomeFirstResponder()
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        locationField.resignFirstResponder()
        goToPage()
        return true
    }
    
    func goToPage() {
        let url = NSURL(string: "https://" + locationField!.text!)!
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
}

