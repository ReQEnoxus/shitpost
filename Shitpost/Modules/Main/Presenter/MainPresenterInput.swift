//
//  MainPresenterInput.swift
//  Shitpost
//
//  Created by Enoxus on 14.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation

protocol MainPresenterInput: AnyObject {
    
    func didFinishLoggingOut(with error: Error?)
}
