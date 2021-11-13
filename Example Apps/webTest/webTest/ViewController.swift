//
//  ViewController.swift
//  webTest
//
//  Created by user206692 on 11/10/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func backBtn(_ sender: Any) {
        if(myWebView.canGoBack) {
            myWebView.goBack()
        } else {
            print("No Back Page")
        }
    }
    
    @IBAction func forwardBtn(_ sender: Any) {
        if(myWebView.canGoForward) {
            myWebView.goForward()
        } else {
            print("No Forward Page")
        }    }
    
    @IBAction func refreshBtn(_ sender: Any) {
        myWebView.reload()
    }
    
    @IBAction func homeBtn(_ sender: Any) {
        let url = URL(string: "https://google.co.kr")
        let urlreq = URLRequest(url: url!)
        myWebView.load(urlreq)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
                        
        let stringURL = "https://www.google.co.kr"
        if let url = URL(string: stringURL) {
            let urlreq = URLRequest(url: url)
            myWebView.load(urlreq)
            myWebView.uiDelegate = self
            myWebView.navigationDelegate = self
            
        }
    }
    
}

