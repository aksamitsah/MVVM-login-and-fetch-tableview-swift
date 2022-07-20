//
//  UserSession.swift
//  workdelight
//
//  Created by Ritesh Singh on 20/07/22.
//

import Foundation


struct UserSession {
    
    let userDefault = UserDefaults.standard
    
    func setValue(token: String){
        userDefault.set(true, forKey: "login")
        userDefault.set( token, forKey: "userToken")
        userDefault.synchronize()
    }
    
    func setEmail(email: String){
        userDefault.set( email, forKey: "email")
        userDefault.synchronize()
    }
    
    func getToken() -> String{
        return (userDefault.value(forKey: "userToken") ?? "") as! String
    }
    
    func getEmail() -> String{
        return (userDefault.value(forKey: "email") ?? "") as! String
    }
    
    func isLogin() -> Bool {
        return (userDefault.value(forKey: "login") ?? false) as! Bool
    }
    
    func isLogout() -> Bool{
        
        userDefault.set(false, forKey: "login")
        userDefault.set( "", forKey: "userToken")
        
        //remind email
        //userDefault.set( "", forKey: "email")
        
        userDefault.synchronize()
        return (userDefault.value(forKey: "login") != nil)
    }
}
