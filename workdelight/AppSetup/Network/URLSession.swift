//
//  URLSession.swift
//  workdelight
//
//  Created by Ritesh Singh on 20/07/22.
//

import Foundation
import SwiftUI

class BaseNetworkCall{
    
    enum ResponseError: Error {
        case custom(String)
        case FetchedError
        case ErrorCodeZero
        case CatchJsonResponse
        case FailureRes
        case NilDataResponse
        case NetworkError
    }
    
    public func getResponse(for urlLink: String, paramsJson : [String: String], completion: @escaping (Result< Data, Error>) -> Void ){
        
        //Network Handler
        if !Handler().isConnectedToNetwork(){
            completion(.failure(ResponseError.custom("Please Check Network Connection")))
            return
        }
        
        //JSON URL FORMETTER
        var params : Data?
        do{
            params = try JSONEncoder().encode(paramsJson)
        }catch{
            params = Data()
        }
        
        guard let url = URL(string: urlLink) else {
            completion(.failure(ResponseError.custom("Invalid URL")))
            return
        }
        
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        
        //Debug print
        print(urlLink)
        print("params: \(paramsJson)")
        
        if !UserSession().getToken().isEmpty{
            request.addValue("Bearer \(UserSession().getToken())", forHTTPHeaderField: "Authorization")
            //Debug print
            print("token: Bearer \(UserSession().getToken())")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = params
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                completion(.failure(ResponseError.custom(String(describing: error))))
                return
            }
            do{
                let dictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? NSDictionary
                
                //Debug print
                print(dictionary as Any)
                
                if dictionary == nil{
                    completion(.failure(ResponseError.CatchJsonResponse))
                    print("CatchJsonResponse")
                    return
                }
                else{
                    completion(.success(data))
                    print("sucessful..!")
                    return
                }
            }
            catch {
                // catch error.
                completion(.failure(ResponseError.CatchJsonResponse))
                print("CatchJsonResponse")
            }
            
        }
        task.resume()
    }
}

