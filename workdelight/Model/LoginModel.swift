//
//  LoginModel.swift
//  workdelight
//
//  Created by Ritesh Singh on 19/07/22.
//

import Foundation
import UIKit

struct LoginModel{
    
    static let identifier = "LoginViewControllerID"
    static var appVersion : String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    static let modelName : String = UIDevice.current.modelName

}

// MARK: - LoginResponseModel
struct LoginResponseModel: Codable {
    let status: Int?
    let message: String?
    let data: LoginResponseData?
}

struct LoginResponseData: Codable {
    //Required Field
    let token: String?
}


