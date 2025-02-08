//
//  Extensions.swift
//  PracticumCounter
//
//  Created by ANTON ZVERKOV on 08.02.2025.
//

import Foundation

extension Date {
    func toString(format: String = "dd MMM HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
