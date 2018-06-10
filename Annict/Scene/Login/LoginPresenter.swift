//
//  LoginPresenter.swift
//  Annict
//
//  Created by 伊東直人 on 2018/06/09.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation

@objc protocol LoginPresenter : class {
    func viewDidLoad()
    @objc func sendOauthToken(_ notification: Notification)
}

class LoginPresenterImplementation: LoginPresenter {
    fileprivate let sendAuthTokenUseCase: SendAuthTokenUseCase
    
    init(sendAuthTokenUseCase: SendAuthTokenUseCase) {
        self.sendAuthTokenUseCase = sendAuthTokenUseCase
        NotificationCenter.default.addObserver(self, selector: #selector(sendOauthToken(_:)), name: .loginViewControllerCloseNotification, object: nil)
    }
    
    @objc func sendOauthToken(_ notification: Notification) {
        if let authCode = notification.userInfo?["authCode"] as? String {
            sendAuthTokenUseCase.sendAuthToken(code: authCode) { (result) in
                print(result)
            }
        }
    }
    
    func viewDidLoad() {
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    

}
