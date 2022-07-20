//
//  LoginViewController.swift
//  workdelight
//
//  Created by Ritesh Singh on 19/07/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    var viewModel = LoginViewModel()
    var indicator = Indicator()
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var emailUI: UIView!
    @IBOutlet weak var passwordUI: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.vc = self
        email.delegate = self
        password.delegate = self
        viewModel.setupUI(email, password, emailUI, passwordUI)

    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        viewModel.ValidationState()
    }
    
    @IBAction func passwordVisibility(_ sender: UIButton) {
        viewModel.updatePasswordToggle(password, sender)
    }
    
    func displayMessage(_ body: String){
        DispatchQueue.main.async {
            Utils.displayAlert(v: self,body)
        }
    }
}

extension LoginViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if password == textField{
            viewModel.ValidationState()
        }
        return true
    }

}
