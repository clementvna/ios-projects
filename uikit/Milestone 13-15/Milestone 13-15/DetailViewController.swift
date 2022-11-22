//
//  DetailViewController.swift
//  Milestone 13-15
//
//  Created by Clément Villanueva on 21/08/2022.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var country: Country?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let country = country else { return }
        
        let html = """
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <style>
                    body {
                        font-size: 150%;
                    }
                </style>
            </head>
            <body>
                <br>Name: \(country.name)</br>
                <br>Motto: \(country.motto)</br>
                <br>Hymn: \(country.hymn)</br>
                <br>National Day: \(country.nationalDay)</br>
                <br>Capital: \(country.capital)</br>
                <br>Currency: \(country.currency)</br>
            </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }

}
