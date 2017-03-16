//
//  RequestData.swift
//  AxxessChallenge
//
//  Created by 新妻英二 on 3/13/17.
//  Copyright © 2017 新妻英二. All rights reserved.
//
//  Class for HTTPRequest handling
//  Intermedial layer, directly return [Content] array back
//

import Foundation
import Alamofire
import SwiftyJSON

enum Response<T>{
    case Success(T)
    case Error(String)
}

struct APIManager {
    static let sharedManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 3
        return SessionManager(configuration: configuration)
    }()
}

class RequestData {
    
    static let requestURL = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
    
    static func downloadJson(completionHandler: @escaping (_ response: Response<[Content]>) -> Void ){
        
        APIManager.sharedManager.request(requestURL, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var result = [Content]()
                for ajson in json.array!{
                    result.append(parse(json: ajson))
                }
                completionHandler(Response.Success(result))
            case .failure(let error):
                completionHandler(Response.Error(error.localizedDescription))
                print(error)
            }
        }
    }
    
    //helper class
    static func parse(json: JSON) -> Content{
        let idJson = json["id"]
        let typeJson = json["type"]
        let dateJson = json["date"]
        let dataJson = json["data"]
        
        let id: String = idJson == nil ? "" : idJson.string!
        let type: contentType = typeJson == "image" ? .image : .text
        let dateFormetter = DateFormatter()
        dateFormetter.dateFormat = "MM/dd/yyyy"
        let date: Date = dateJson == nil || dateJson == "" ? Date() : dateFormetter.date(from: dateJson.string!)!
        let data: String = dataJson == nil ? "" : dataJson.string!
        
        return Content(id: id, type: type, date: date, data: data)
    }

}
