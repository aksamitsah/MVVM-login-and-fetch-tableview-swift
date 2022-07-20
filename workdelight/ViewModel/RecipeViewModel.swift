//
//  RecipeViewModel.swift
//  workdelight
//
//  Created by Ritesh Singh on 20/07/22.
//

import Foundation

import Foundation
import UIKit

class RecipeViewModel{
    
    weak var vc: RecipeViewController?
    var data: [RecipeResponse] = []
    
    static func openVC(parentVC: UIViewController){
        if let openViewController = K.StoryBoard.mainStoryBoard.instantiateViewController(withIdentifier: RecipeModel.identifier) as? RecipeViewController {
            openViewController.modalPresentationStyle = .fullScreen
            parentVC.present(openViewController, animated: true)
        }
    }
    
    func apiRequetCall(){
        
        vc?.indicator.showIndicator()
        
        BaseNetworkCall().getResponse(for: K.apis.recipe, paramsJson: [:])
        { [self] result in
            
            DispatchQueue.main.async{
                self.vc?.indicator.hideIndicator()
            }
            
            switch result {
                
            case .success(let datas):
                
                do{
                    
                    let resp :RecipeResponseModel = try JSONDecoder().decode(RecipeResponseModel.self, from: datas)
                    
                    DispatchQueue.main.async {
                        
                        if resp.status == 0{
                            self.vc?.displayMessage(resp.message ?? "")
                            return
                        }
                        //print(resp.data?[0].recipe)
                        guard let rec = resp.data, rec.count > 0 else {
                            return
                        }
                        for ds in rec {
                            
                            if let recepi = ds.recipe, recepi.count > 0 {
                                self.data.append(contentsOf: recepi)
                            }
                        }
                        print(self.data.count)
                        
                        DispatchQueue.main.async{
                            self.vc?.tableViewReload()
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
    
    func logout(){
        if UserSession().isLogout(){
            LoginViewModel.openVC(parentVC: self.vc!)
        }
    }
}
