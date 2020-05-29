//
//  ViewController.swift
//  Browser
//
//  Created by Alexandr Kulya on 27.05.2020.
//  Copyright © 2020 Alexandr Kulya. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, UITextFieldDelegate {
    var managerOfMarkers: ManagerOfMarkers!
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var seatchField: UITextField!
    
    var actInd: UIActivityIndicatorView = {
        let actInd = UIActivityIndicatorView()
        actInd.translatesAutoresizingMaskIntoConstraints = false
        return actInd
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        managerOfMarkers = ManagerOfMarkers()
        seatchField.text = "https://www.google.com"
        setupURL(seatch: seatchField.text!)
        self.webView.uiDelegate = self
        self.webView?.navigationDelegate = self
        self.seatchField.delegate = self
        setupRefreshLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        seatchField.reloadInputViews()
    }
    
    func setupRefreshLayout() {
        view.addSubview(actInd)
        actInd.hidesWhenStopped = true
        actInd.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        actInd.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @IBAction func save() {
        guard let currentURL = webView.url else { return }
        managerOfMarkers.add(marker: Marker(text: "\(currentURL)"))
    }
    
    @IBAction func seatchButton() {
        setupURL(seatch: seatchField.text!)
//        if let text = seatchField.text {
//            if let seatch = URL(string: text) {
//                let field = URLRequest(url: seatch)
//                webView.load(field)
//            }
//        }
    }
    
    @IBAction func goBackButton() {
        if webView.canGoBack {
            webView.goBack()
        }
        guard let currentURL = webView.url else { return }
        self.seatchField.text = "\(currentURL))"
    }
    
    @IBAction func goForwardButton() {
        if webView.canGoForward {
            webView.goForward()
        }
        guard let currentURL =  webView.url else { return }
        self.seatchField.text = "\(currentURL))"
    }
    
    @IBAction func markers() {
        performSegue(withIdentifier: "goToMarkers", sender: nil)
    }
    
    func setupURL(seatch: String) {
        guard let url = URL(string: seatch) else { return }
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToMarkers" else { return }
        guard let markersVC = segue.destination as? TableViewController else { return }
        markersVC.managerOfMarkers = managerOfMarkers
    }
    
    @IBAction func unwindToMainScreen(_ unwindSegue: UIStoryboardSegue) {
        setupURL(seatch: seatchField.text!)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let currentURL = webView.url else { return }
        seatchField.text = "\(currentURL)"
        decisionHandler(.allow)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        setupURL(seatch: seatchField.text!)
        seatchField.resignFirstResponder()
        return true
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        actInd.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        actInd.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        actInd.stopAnimating()
    }
    
}


