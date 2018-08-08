//
//  DateUtility.swift
//  Chat-App
//
//  Created by Danny Bokati on 5/28/18.
//  Copyright © 2018 Gtech Developeres. All rights reserved.
//

import Foundation

class Utility {

class func stringToDate(date: String?) -> Date?{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    if let oDate = date , let dataDate = dateFormatter.date(from: oDate){
        return dataDate
    }
    return nil
}
}
