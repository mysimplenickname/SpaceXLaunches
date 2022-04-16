//
//  DataFormatterService.swift
//  SpaceXLaunches
//
//  Created by Leo Malikov on 17.04.2022.
//

import Foundation

enum DateFormattingOptions: String {
    case simple = "YYYY-MM-dd"
    case complex = "YYYY-MM-dd'T'HH:mm:ss.000Z"
}

class DataFormatterService {
    
    static func dateFromString(dateString: String, option: DateFormattingOptions) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = option.rawValue
        return dateFormatter.date(from: dateString)
        
    }
    
    static func formatDate(dateString: String, option: DateFormattingOptions) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, YYYY"
        
        if let date = DataFormatterService.dateFromString(dateString: dateString, option: option) {
            return dateFormatter.string(from: date)
        } else {
            return dateString
        }
        
    }

    static func formatCountry(country: String) -> String {
        switch country {
        case "United States":
            return "США"
        case "Republic of the Marshall Islands":
            return "Маршалловы Острова"
        default:
            return country
        }
    }

    static func formatCost(cost: Double) -> String {
        let costMil = cost / 1000000
        if costMil - Double(Int(costMil)) == 0.0 {
            return "$\(Int(costMil)) млн"
        } else {
            return "$\(costMil) млн"
        }
    }
    
}
