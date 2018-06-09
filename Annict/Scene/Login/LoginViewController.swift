//
//  LoginViewController.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/07.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var webView: WKWebView!
    lazy var progressView: UIProgressView = {
        // make progress bar on navigationbar
        let progressView = UIProgressView(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.frame.size.height - 2, width: self.view.frame.size.width, height: 10))
        progressView.progressViewStyle = .bar
        progressView.progressTintColor = UIColor.lightGray

        return progressView
    }()
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func loadView() {
        super.loadView()
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        self.navigationController?.navigationBar.tintColor = UIColor.lightGray
        
        self.navigationController?.navigationBar.addSubview(progressView)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        self.navigationItem.title = NSLocalizedString("login", comment: "")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        
        //setting webview observer
        self.webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        webView.load(AuthorizationRequest().urlRequest)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            // when estimatedProgress changed
            self.progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
        }else if keyPath == "loading"{
            // when loading changed
            UIApplication.shared.isNetworkActivityIndicatorVisible = self.webView.isLoading
            if self.webView.isLoading {
                self.progressView.setProgress(0.1, animated: true)
            }else{
                // when loading finished
                self.progressView.setProgress(0.0, animated: false)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController : WKUIDelegate {
    
}

extension LoginViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        #if DEBUG
        print("url:[\(String(describing: webView.url))]")
        #endif
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // open app by custom url sheme
        if let url = webView.url , url.scheme == "jp.annict.uaw" {
            UIApplication.shared.open(url, options: [:]) { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
}
