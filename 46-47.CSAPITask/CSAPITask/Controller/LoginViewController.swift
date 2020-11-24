//
//  LoginViewController.swift
//  CSAPITask
//
//  Created by Aleksandr on 02/10/2020.
//  Copyright © 2020 Aleksandr Shushkov. All rights reserved.
//

import UIKit
import WebKit

class LoginViewController: UIViewController, WKNavigationDelegate {
    
    struct Premissions: OptionSet {
        let rawValue: Int
        
        static let friends = Premissions(rawValue: 1<<1)
    }

    var webView: WKWebView!
    var completion: (()->())?
    
    init(completion: (()->())? = nil) {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let premissions: Premissions = [.friends]
        
        let myURL = URL(string:"""
https://oauth.vk.com/authorize?\
client_id=7420270\
&display=mobile\
&redirect_uri=https://oauth.vk.com/blank.html\
&scope=\(premissions.rawValue)\
&response_type=token\
&v=5.124\
&revoke=1
""")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        if let url = navigationResponse.response.url, let fragment = url.fragment {
            
            var parameters = [String: String]()
            
            let properties = fragment.split(separator: "&")
            for property in properties {
                let keyAndValue = property.split(separator: "=")
                guard let key = keyAndValue.first, let value = keyAndValue.last else {
                    continue
                }
                parameters[String(key)] = String(value)
            }
            
            if parameters.keys.contains("access_token"),
                let accessToken = parameters["access_token"],
                let stringTimeInterval = parameters["expires_in"],
                let timeInterval = Double(stringTimeInterval),
                let userID = parameters["user_id"] {
                
                AccessToken.add(token: accessToken,
                                expiresDate: Date(timeIntervalSinceNow: timeInterval),
                                userID: userID)
                
                decisionHandler(.cancel)
                
                completion?()
                
                self.dismiss(animated: true, completion: nil)
                
                return
            }
        }
        
        decisionHandler(.allow)
    }
}

