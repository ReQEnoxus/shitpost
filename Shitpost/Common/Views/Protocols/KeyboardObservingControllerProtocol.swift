//
//  KeyboardObservingControllerProtocol.swift
//  Shitpost
//
//  Created by Enoxus on 10.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import UIKit

@objc protocol KeyboardObservingControllerProtocol: AnyObject {
    
    @objc func didReceiveKeyboardWillShowNotification(_ notification: Notification)
    @objc func didReceiveKeyboardWillHideNotification(_ notification: Notification)
}

extension KeyboardObservingControllerProtocol {
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveKeyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveKeyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func stopObservingKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
}
