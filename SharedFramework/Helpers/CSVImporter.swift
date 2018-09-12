//
//  CSVImporter.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 9/12/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import Foundation

enum CSVImportError: Error {
    case cantCreateURL
}

class CSVImporter {
    
    static func importCSVNamed(_ name: String) throws -> [[String]] {
        guard let url = Bundle(for: self).url(forResource: name, withExtension: "csv") else {
            throw CSVImportError.cantCreateURL
        }
        
        let contents = try String(contentsOf: url)
        let lines = contents.components(separatedBy: "\n")
        
        let linesWithBits = lines.map { line -> [String] in
            return line.components(separatedBy: ",")
                .map { string in
                    let stripQuotes = string.trimmingCharacters(in: CharacterSet(charactersIn: "\""))
                    return stripQuotes
                }
        }
        
        return linesWithBits
    }
}
