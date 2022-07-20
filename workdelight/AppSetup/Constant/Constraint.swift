//
//  Constraint.swift
//  workdelight
//
//  Created by Ritesh Singh on 19/07/22.
//

import UIKit
import Foundation

public struct K{

    public struct apis{
        
        private static var base = "https://dietangel.shtibel.com/dietAngel/public/api/"
        static var baseImage = "https://dietangel.shtibel.com/dietAngel/public/"
    
        static var login = "\(base)user/login_faster"
        static var recipe = "\(base)user/recipe"

    }
    
    public struct StoryBoard{
        
        static let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        static let lunchScreenStoryBoard = UIStoryboard.init(name: "LaunchScreen", bundle: nil)
        
    }
    
    public struct Colors{
        
        static let secondaryColor = UIColor(named: "secondary")
        static let  primaryColor = UIColor(named: "primary")
        //Utils.hexStringToUIColor(hex: "#ACEBD0")
        //static let bgBtnGreen = hexStringToUIColor(hex: "#ACEBD0")
        
    }
    
    public struct Images{
        static let appIcon = UIImage(named: "icon")
        static let imageNotFound = UIImage(named: "image_not_found")
        
    }
    
    
    
}

