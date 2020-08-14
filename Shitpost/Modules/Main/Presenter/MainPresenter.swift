//
//  MainPresenter.swift
//  Shitpost
//
//  Created by Enoxus on 14.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

class MainPresenter: MainPresenterInput {
    
    weak var view: MainViewInput!
    
    func didFinishLoggingOut(with error: Error?) {
        if let error = error {
            NSLog(error.localizedDescription)
        }
        else {
            view.signOffFinished()
        }
    }
}
