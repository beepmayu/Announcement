//
//  DataManager.swift
//  Announcement
//
//  Created by Mayu on 16/11/17.
//  Copyright © 2017 Mayu. All rights reserved.
//

import Foundation
import Alamofire


struct Annoucement {
    var title : String?
    var date : String?
    var html : String?
}
class DataManager {
    static let shared = DataManager()
    
    var annoucementList : [Annoucement]?
    var selectedAnnoucement : Annoucement?

    
    func loadData(url : String,successHandler:@escaping (Any) -> Void , failureHandler:@escaping (Error) -> Void) {
        Alamofire.request(url).responseJSON { response in
            if response.error != nil{
                failureHandler(response.error!)
                return
            }
            guard let json : NSArray = response.result.value as? NSArray else {return}
            self.annoucementList = json.map{ dic -> Annoucement in
                var announcement = Annoucement()
                if dic is NSDictionary{
                    let temp = dic as! NSDictionary
                    announcement.date = temp["ANNOUNCEMENT_DATE"] as? String
                    announcement.title = temp["ANNOUNCEMENT_TITLE"] as? String
                    announcement.html = temp["ANNOUNCEMENT_HTML"] as? String

                }
                return announcement
            }
            successHandler(json)
        
        }
        
    }
    
  
    
}
