//
//  Font Extensions.swift
//  MyMeSwift
//
//  Created by Leah Vogel on 07/10/2018.
//  Copyright © 2018 Orcam. All rights reserved.
//

import Foundation
import UIKit

enum CustomFontWeight {
    case light, lightItalic, regular, italic, medium, mediumItalic, bold, boldItalic, black, blackItalic
}

let CUSTOM_FONT_NAME = "Montserrat"

class OrcamFont: UIFont {
    static func font(_ weight: CustomFontWeight, _ size: CGFloat) -> UIFont {
        return UIFont(name: customFontNameForWeight(customFontWeight: weight), size: size)!
    }
    
    static func font(_ size: CGFloat) -> UIFont {
        return UIFont(name: customFontNameForWeight(customFontWeight: DEFAULT_CUSTOM_FONT_WEIGHT), size: size)!
    }
    
    static func font(_ weight: CustomFontWeight) -> UIFont {
        return UIFont(name: customFontNameForWeight(customFontWeight: weight), size: DEFAULT_FONT_SIZE)!
    }
    
    static func font() -> UIFont {
        return UIFont(name: customFontNameForWeight(customFontWeight: DEFAULT_CUSTOM_FONT_WEIGHT), size: DEFAULT_FONT_SIZE)!
    }
    
    private static func customFontNameForWeight(customFontWeight: CustomFontWeight) -> String {
        switch customFontWeight {
        case .light:
            return CUSTOM_FONT_NAME + "-Light"
        case .lightItalic:
            return CUSTOM_FONT_NAME + "-LightItalic"
        case .regular:
            return CUSTOM_FONT_NAME + "-Regular"
        case .italic:
            return CUSTOM_FONT_NAME + "-Italic"
        case .medium:
            return CUSTOM_FONT_NAME + "-Medium"
        case .mediumItalic:
            return CUSTOM_FONT_NAME + "-MediumItalic"
        case .bold:
            return CUSTOM_FONT_NAME + "-Bold"
        case .boldItalic:
            return CUSTOM_FONT_NAME + "-BoldItalic"
        case .black:
            return CUSTOM_FONT_NAME + "-Black"
        case .blackItalic:
            return CUSTOM_FONT_NAME + "-BlackItalic"
        }
    }
    
    class var header1: UIFont {
        return UIFont(name: customFontNameForWeight(customFontWeight: .medium), size: 36.0)!
    }
    
    class var header6: UIFont {
        return UIFont(name: customFontNameForWeight(customFontWeight: .medium), size: 18.0)!
    }
    
    class var bulletText: UIFont {
        return UIFont(name: customFontNameForWeight(customFontWeight: .regular), size: 18.0)!
    }
    
    class var bodyText2: UIFont {
        return UIFont(name: customFontNameForWeight(customFontWeight: .regular), size: 18.0)!
    }

    class var link: UIFont {
        return UIFont(name: customFontNameForWeight(customFontWeight: .light), size: 16.0)!
    }
    
    class var paragraphText: UIFont {
        return UIFont(name: customFontNameForWeight(customFontWeight: .regular), size: 14.0)!
    }
    
    class var buttonText: UIFont {
        return UIFont(name: customFontNameForWeight(customFontWeight: .bold), size: 13.55)!
    }
}

let DEFAULT_FONT_SIZE: CGFloat = 17.0
let DEFAULT_CUSTOM_FONT_WEIGHT: CustomFontWeight = .regular
let DEFAULT_BUTTON_CORNER_RADIUS: CGFloat = 14.0
let DEFAULT_BUTTON_HEIGHT: CGFloat = 45.0
let PERSON_SCREEN_BACKGROUND_COLOR = UIColor.lightGray
