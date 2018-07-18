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
    @objc func receiveOauthToken(_ notification: Notification)
}

class LoginPresenterImplementation: LoginPresenter {
    fileprivate let receiveAuthTokenUseCase: ReceiveAuthTokenUseCase
    
    init(receiveAuthTokenUseCase: ReceiveAuthTokenUseCase) {
        self.receiveAuthTokenUseCase = receiveAuthTokenUseCase
        NotificationCenter.default.addObserver(self, selector: #selector(receiveOauthToken(_:)), name: .loginViewControllerCloseNotification, object: nil)
    }
    
    @objc func receiveOauthToken(_ notification: Notification) {
        if let authCode = notification.userInfo?["authCode"] as? String {
            receiveAuthTokenUseCase.receiveAuthToken(code: authCode) { (result) in
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
