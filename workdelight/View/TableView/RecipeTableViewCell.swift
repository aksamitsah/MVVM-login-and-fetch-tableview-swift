//
//  RecipeTableViewCell.swift
//  workdelight
//
//  Created by Ritesh Singh on 20/07/22.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var UIMain: UIView!
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        UILayoutDesign.setCardView(with: UIMain)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupData(resp : RecipeResponse){
        heading.text = resp.title
        LoadImage().fetch(urlString: resp.image ?? "", img: images)
        
        if resp.summary?.count ?? 0 > 0{
            desc.text = resp.summary
        }
        else{
            desc.text = Utils.dateFormrtter(resp.updated_at ?? "")
        }
    }
    
    class var reuseIdentifier: String {
        return "ResRecipeTableViewCell"
    }
    
    class var nibName: String {
        return "RecipeTableViewCell"
    }
    
}
