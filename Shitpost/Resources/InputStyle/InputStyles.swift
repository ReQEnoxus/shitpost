//
//  InputStyles.swift
//  Shitpost
//
//  Created by Enoxus on 10.08.2020.
//  Copyright © 2020 Enoxus. All rights reserved.
//

import Foundation
import AnimatedTextInput

struct ShitpostInputStyle: AnimatedTextInputStyle {
    var activeColor: UIColor = .systemGreen
    
    var placeholderInactiveColor: UIColor = UIColor.gray.withAlphaComponent(0.5)
    
    var inactiveColor: UIColor = UIColor.gray.withAlphaComponent(0.5)
    
    var lineInactiveColor: UIColor = UIColor.gray.withAlphaComponent(0.2)
    
    var lineActiveColor: UIColor = UIColor.systemGreen.withAlphaComponent(0.5)
    
    var lineHeight: CGFloat = 1.0 / UIScreen.main.scale
    
    var errorColor: UIColor = .systemRed
    
    var textInputFont: UIFont = UIFont.systemFont(ofSize: 14)
    
    var textInputFontColor: UIColor = UIColor.black
    
    var placeholderMinFontSize: CGFloat = 12
    
    var counterLabelFont: UIFont? = UIFont.systemFont(ofSize: 12)
    
    var leftMargin: CGFloat = 0
    
    var topMargin: CGFloat = 20
    
    var rightMargin: CGFloat = 0
    
    var bottomMargin: CGFloat = 10
    
    var yHintPositionOffset: CGFloat = 7
    
    var yPlaceholderPositionOffset: CGFloat = 0
    
    var textAttributes: [String : Any]? = nil
}

internal enum InputStyle {
    internal enum Auth {
        static let inputStyle = ShitpostInputStyle()
    }
}
