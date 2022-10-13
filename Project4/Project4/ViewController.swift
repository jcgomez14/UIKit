//
//  ViewController.swift
//  Project4
//
//  Created by Juan Cruz on 12/10/2022.
//

import UIKit
import WebKit


class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView : WKWebView!
    var progressView : UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com" ]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://" + websites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
       
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        
        
    
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
     //   let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let backweb = UIBarButtonItem(title: "Back", style: .plain, target: webView, action: #selector(webView.goBack))
        let forwardkweb = UIBarButtonItem(title: "Forward", style: .plain, target: webView, action: #selector(webView.goForward))
     
        
        toolbarItems = [backweb, spacer, refresh, spacer, forwardkweb]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        
        
    }

    @objc func openTapped(){
        let ac = UIAlertController(title: "Open page", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)

    }
    
    func openPage(action: UIAlertAction){
        let url = URL(string: "https://" + action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url
       
        
        if let host = url?.host{
            for website in websites {
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
            
        }
        
        decisionHandler(.cancel)
    }
 
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgess"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    

}
