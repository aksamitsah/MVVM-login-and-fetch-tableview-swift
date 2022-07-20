//
//  LoginViewModel.swift
//  workdelight
//
//  Created by Ritesh Singh on 19/07/22.
//

import Foundation
import UIKit

class LoginViewModel{
    
    weak var vc: LoginViewController?
    
    static func openVC(parentVC: UIViewController){
        
        if let openViewController = K.StoryBoard.mainStoryBoard.instantiateViewController(withIdentifier: LoginModel.identifier) as? LoginViewController {
            openViewController.modalPresentationStyle = .fullScreen
            parentVC.present(openViewController, animated: true)
            
        }
    }
    
    func apiRequetCall(jsonRes: [String: String]){
        
        vc?.indicator.showIndicator()
        
        BaseNetworkCall().getResponse(for: K.apis.login, paramsJson: jsonRes)
        { [self] result in
            
            DispatchQueue.main.async{
                self.vc?.indicator.hideIndicator()
            }
            
            switch result {
                
            case .success(let datas):
                
                do{
                    
                    let resp :LoginResponseModel = try JSONDecoder().decode(LoginResponseModel.self, from: datas)
                    
                    DispatchQueue.main.async {
                        
                        if resp.status == 0{
                            self.vc?.displayMessage(resp.message ?? "")
                            return
                        }
                        
                        guard let token = resp.data?.token, token.count > 10 else {
                            return
                        }
                        UserSession().setValue(token: token)
                        if UserSession().isLogin(){
                            print("login")
                            RecipeViewModel.openVC(parentVC: self.vc!)
                        }
                    }
                    
                }
                catch {
                    self.vc?.displayMessage("Json Response Error")
                }
                
                
            case .failure(let errorMsg):
                DispatchQueue.main.async {
                    self.vc?.displayMessage(errorMsg.localizedDescription)
                }
            }
        }
        
    }
    
    func ValidationState(){
        
        guard let email = vc?.email.text, !email.isEmpty, Validation.isValidEmail(email) else {
            vc?.displayMessage("Please Enter Valid Email Address")
            return
        }
        
        UserSession().setEmail(email: email)
        
        guard let password = vc?.password.text, !password.isEmpty, password.count >= 5 else {
            vc?.displayMessage("Please Enter Valid Password")
            vc?.password.text = ""
            return
        }
        
        
        //Note: OneSignal Required Apple dev ID
        apiRequetCall(jsonRes:
                        [
                            "email" : email,
                            "password" : password,
                            "one_signal_id": "123",
                            "app_version":LoginModel.appVersion,
                            "device_type":LoginModel.modelName
                        ])
        
    }
    
    //change password visiable state
    func updatePasswordToggle(_ password: UITextField,_ sender: UIButton){
        
        password.isSecureTextEntry.toggle()
        if password.isSecureTextEntry {
            if let image = UIImage(systemName: "eye.fill") {
                sender.setImage(image, for: .normal)
            }
        } else {
            if let image = UIImage(systemName: "eye.slash.fill") {
                sender.setImage(image, for: .normal)
            }
        }
    }
    
    //UIVIEW SETUP
    func setupUI(_ email: UITextField, _ password: UITextField, _ emailUI: UIView,_ passwordUI: UIView){
        
        email.addDoneButtonOnKeyboard()
        password.addDoneButtonOnKeyboard()
        
        UILayoutDesign.setBorderDefault(with: emailUI)
        UILayoutDesign.setBorderDefault(with: passwordUI)
        
        UILayoutDesign.setCharacterSpace(email, ltspace: true)
        UILayoutDesign.setCharacterSpace(password, ltspace: true)
        
        UITextField.connectFields(fields: [email,password])
        
        email.text = UserSession().getEmail()
        
        
    }
    
}
