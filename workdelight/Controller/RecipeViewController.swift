//
//  RecipeViewController.swift
//  workdelight
//
//  Created by Ritesh Singh on 20/07/22.
//

import UIKit

class RecipeViewController: UIViewController {

    var viewModel = RecipeViewModel()
    let indicator = Indicator()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.vc = self
        viewModel.apiRequetCall()
        
        tableView.register(UINib(nibName: RecipeTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: RecipeTableViewCell.reuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    @IBAction func LogoutBtn(_ sender: UIButton) {
        viewModel.logout()
    }
    
    func displayMessage(_ body: String){
        DispatchQueue.main.async {
            Utils.displayAlert(v: self,body)
        }
    }

}

extension RecipeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("index selectde: ",indexPath.row)

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableViewCell.reuseIdentifier, for: indexPath) as! RecipeTableViewCell
      
        cell.setupData(resp: viewModel.data[indexPath.row])
        return cell
    }
    
    //Animation Show
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //Anim 001
        //delay 0.2 each *indexPath.row having 0 delay
        cell.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func tableViewReload(){
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
}
