//
//  AnnotationViewController.swift
//  Project 16
//
//  Created by Clément Villanueva on 24/08/2022.
//

import UIKit
import WebKit

class AnnotationViewController: UIViewController {
    
    
    @IBOutlet var webView: WKWebView!
    var capital: Capital!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://wikipedia.org/wiki/\(capital.title!)") else { return }
                
        webView.load(URLRequest(url: url))
    }

}
