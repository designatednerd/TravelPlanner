//
//  AirportImporter.swift
//  SharedFramework
//
//  Created by Ellen Shapiro on 9/12/18.
//  Copyright © 2018 Designated Nerd Software. All rights reserved.
//

import CoreData
import Foundation

public struct AirportImporter {
    
    public static func needsImport() -> Bool {
        return CoreDataManager.shared.mainContext.dns_allOf(Airport.self).isEmpty
    }
    
    public static func importAirports(in context: NSManagedObjectContext = CoreDataManager.shared.mainContext) throws {
        
        let lines = try CSVImporter.importCSVNamed("airports")
        
        _ = lines.compactMap { stringsToAirport($0, context: context) }
        
        try context.save()
    }
    
    private static func stringsToAirport(_ strings: [String], context: NSManagedObjectContext) -> Airport? {
        guard strings.count == 14 else {
            // Invalid format
            return nil
        }

        let id = strings[0]
        let name = strings[1]
        let city = strings[2]
        let country = strings[3]
        let iataCode = strings[4]
        let icaoCode = strings[5]
        let timeZone = strings[11]

        
        let airport = Airport.dns_create()
        airport.id = id
        airport.name = name
        airport.city = city
        airport.country = country
        airport.iataCode = iataCode
        airport.icaoCode = icaoCode
        airport.timeZoneName = timeZone
        
        return airport
    }
}
