//
//  AirlineImporter.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 9/11/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import CoreData
import Foundation

enum AirlineImporterError: Error {
    case cantCreateURL
}

public class AirlineImporter {
    
    public static func needsImport() -> Bool {
        return CoreDataManager.shared.mainContext.dns_allOf(Airline.self).isEmpty
    }
    
    public static func importAirlines(in context: NSManagedObjectContext = CoreDataManager.shared.mainContext) throws {
        
        let lines = try CSVImporter.importCSVNamed("airlines")
        
        _ = lines.compactMap { stringsToAirline($0, context: context) }

        try context.save()
    }
    
    static func stringsToAirline(_ strings: [String], context: NSManagedObjectContext) -> Airline? {
        guard strings.count == 8 else {
            // Invalid format
            return nil
        }
        
        let isActive = strings[7]
        
        if isActive == "N" {
            // This airline is not an active airline
            return nil
        }
        
        let identifier = strings[0]
        
        let name = strings[1]
        let iataCode = strings[3]
        let icaoCode = strings[4]
        let callSign = strings[5]
        let country = strings[7]
        
        let airline = Airline.dns_create(in: context)
        airline.id = identifier
        airline.name = name
        airline.iataCode = iataCode
        airline.icaoCode = icaoCode
        airline.callSign = callSign
        airline.country = country
        
        return airline
    }
}
