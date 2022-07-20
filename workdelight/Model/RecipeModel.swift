//
//  RecipeModel.swift
//  workdelight
//
//  Created by Ritesh Singh on 20/07/22.
//

import Foundation

struct RecipeModel{
    static let identifier = "RecipeViewControllerID"
}



// MARK: - Welcome
struct RecipeResponseModel: Codable {
    let status: Int?
    let data: [DataResponse]?
    let message: String?
    //let dietician: DieticianResponse?
    //let favourites: [favourites]?
}

struct DataResponse: Codable {
    let recipe: [RecipeResponse]?
    let id: Int?
    let user_id: Int?
    let name: String?
    let deleted_at: String?
    let deleted_by: String?
    let created_datetime: String?
    let updated_datetime: String?
    let created_at: String?
    let updated_at: String?
}


// MARK: - DieticianResponse
struct DieticianResponse: Codable {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let full_name: String?
    let image: String?
    let bmi: Double?
    let weekLose: String?
    let totalLose: String?
    let totalLoseWeb: String?
    let weekLoseWeb: Int?
    let lastUseMessage: LastUseMessage?
}

struct LastUseMessage: Codable {
    let message: String?
    let colour: String?
}
    
    struct RecipeResponse: Codable {
        let title: String?
        let image: String?
        var summary: String? = ""
        let updated_at: String?
        
//        let id: Int?
//        let user_id: Int?
//        let category: String?
//        let number_of_dishes: String?
//        let yellow_amount: String?
//        let red_amount: String?
//        let prepare_time: String?
//        let settings: String?
//        let recipe_description: String?
//        let deleted_at: String?
//        let deleted_by: String?
//        let createdDatetime: String?
//        let updatedDatetime: String?
//        let updateTime: String?
//        let created_at: String?
//        let updated_at: String?
//        let settings_in_array: [SettingsInArray]?
//        let pivot: Pivot?
    }
    
    struct Pivot: Codable {
        let categoryID: String?
        let recipeID: String?
    }
