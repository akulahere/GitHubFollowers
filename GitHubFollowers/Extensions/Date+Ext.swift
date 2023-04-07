//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Dmytro Akulinin on 07.04.2023.
//

import Foundation


extension Date {
  func  convertToMonthYearFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM yyyy"
    return dateFormatter.string(from: self)
  }
}
