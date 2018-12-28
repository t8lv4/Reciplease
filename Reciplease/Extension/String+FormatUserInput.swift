//
//  String+FormatUserInput.swift
//  Reciplease
//
//  Created by Morgan on 13/12/2018.
//  Copyright © 2018 Morgan. All rights reserved.
//

import Foundation

extension String {
    /**
     Format a string

     - parameter separator: Separate words in a returned string

     Provide a formatted string with a given separator
     in order to fit with e.g. networking parameters or UI display requirements.
     The method will clear out duplicate words and returns words in no particular order.
     */
    func format(with separator: String) -> String {
        let string = self.replacingOccurrences(of: "\\s+|\\s", with: " ", options: .regularExpression)
            .trimmingCharacters(in:.whitespacesAndNewlines)
        let stringSet = Set(string.components(separatedBy: " "))
        let formattedString = stringSet.joined(separator: separator)

        return formattedString
    }
}
